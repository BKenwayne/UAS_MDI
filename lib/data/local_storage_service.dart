import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/user_profile.dart';

/// Menyimpan sesi login (SharedPreferences) dan seluruh progress pengguna (SQLite).
class LocalStorageService extends ChangeNotifier {
  final SharedPreferences _prefs;
  final Database _db;

  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyLoggedUsername = 'logged_in_username';

  UserProfile? _currentUser;

  LocalStorageService(this._prefs, this._db);

  static late final LocalStorageService instance;

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();

    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'nusafauna.db');

    final db = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await _createUsersTable(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await _migrateUsersTableV2(db);
        }
      },
    );

    final service = LocalStorageService(prefs, db);
    instance = service;

    await service._seedDefaultUser();

    if (service.isLoggedIn()) {
      await service.reloadCurrentUser();
    }

    return service;
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  String? getLoggedUsername() {
    return _prefs.getString(_keyLoggedUsername);
  }

  UserProfile? getCurrentUser() {
    return _currentUser;
  }

  /// Muat ulang profil aktif dari SQLite (berguna setelah restart aplikasi).
  Future<UserProfile?> reloadCurrentUser() async {
    final username = getLoggedUsername();
    if (username == null || !isLoggedIn()) {
      _currentUser = null;
      notifyListeners();
      return null;
    }

    _currentUser = await _getUserFromDb(username);
    notifyListeners();
    return _currentUser;
  }

  Future<void> saveCurrentUser(UserProfile profile) async {
    _currentUser = profile;
    await _db.insert(
      'users',
      profile.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<bool> registerUser(String username) async {
    final sanitizedUsername = username.trim();
    if (sanitizedUsername.isEmpty) return false;

    final existingUser = await _getUserFromDb(sanitizedUsername);
    if (existingUser != null) {
      return false;
    }

    final newProfile = UserProfile.initial(sanitizedUsername);
    await _db.insert(
      'users',
      newProfile.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  Future<bool> registerUserFull({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final sanitizedEmail = email.trim().toLowerCase();
    if (sanitizedEmail.isEmpty || password.isEmpty) return false;

    final existingUser = await _getUserFromDb(sanitizedEmail);
    if (existingUser != null) {
      return false;
    }

    final now = DateTime.now();
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final joinedAtString = '${months[now.month - 1]} ${now.year}';

    final newProfile = UserProfile(
      username: sanitizedEmail,
      fullName: fullName.trim(),
      email: sanitizedEmail,
      password: password,
      bio: '',
      quizScores: const {},
      completedQuizzes: const [],
      earnedBadges: const [],
      viewedAnimalIds: const [],
      activeBadge: null,
      notifyEnabled: true,
      avatarBase64: null,
      joinedAt: joinedAtString,
    );

    await _db.insert(
      'users',
      newProfile.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  Future<bool> loginUser(String username) async {
    final sanitizedUsername = username.trim();
    if (sanitizedUsername.isEmpty) return false;

    var existingUser = await _getUserFromDb(sanitizedUsername);

    if (existingUser == null) {
      await registerUser(sanitizedUsername);
      existingUser = await _getUserFromDb(sanitizedUsername);
    }

    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyLoggedUsername, sanitizedUsername);
    _currentUser = existingUser;
    notifyListeners();
    return true;
  }

  Future<bool> loginUserFull(String email, String password) async {
    final sanitizedEmail = email.trim().toLowerCase();
    if (sanitizedEmail.isEmpty) return false;

    final profile = await _getUserFromDb(sanitizedEmail);
    if (profile == null) {
      return false;
    }

    if (profile.password == password) {
      await _prefs.setBool(_keyIsLoggedIn, true);
      await _prefs.setString(_keyLoggedUsername, sanitizedEmail);
      _currentUser = profile;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _prefs.setBool(_keyIsLoggedIn, false);
    await _prefs.remove(_keyLoggedUsername);
    _currentUser = null;
    notifyListeners();
  }

  Future<void> clearAllData() async {
    await _prefs.clear();
    _currentUser = null;
    await _db.delete('users');
    notifyListeners();
  }

  Future<UserProfile?> _getUserFromDb(String username) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isEmpty) {
      return null;
    }

    return UserProfile.fromDbMap(maps.first);
  }

  static Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        username TEXT PRIMARY KEY,
        fullName TEXT,
        email TEXT,
        password TEXT,
        bio TEXT,
        quizScores TEXT,
        completedQuizzes TEXT,
        earnedBadges TEXT,
        viewedAnimalIds TEXT,
        activeBadge TEXT,
        notifyEnabled INTEGER,
        avatarBase64 TEXT,
        joinedAt TEXT
      )
    ''');
  }

  static Future<void> _migrateUsersTableV2(Database db) async {
    await db.execute('''
      CREATE TABLE users_new (
        username TEXT PRIMARY KEY,
        fullName TEXT,
        email TEXT,
        password TEXT,
        bio TEXT,
        quizScores TEXT,
        completedQuizzes TEXT,
        earnedBadges TEXT,
        viewedAnimalIds TEXT,
        activeBadge TEXT,
        notifyEnabled INTEGER,
        avatarBase64 TEXT,
        joinedAt TEXT
      )
    ''');
    await db.execute('''
      INSERT INTO users_new (
        username, fullName, email, password, bio,
        quizScores, completedQuizzes, earnedBadges, viewedAnimalIds,
        activeBadge, notifyEnabled, avatarBase64, joinedAt
      )
      SELECT
        username, fullName, email, password, bio,
        quizScores, completedQuizzes, earnedBadges, viewedAnimalIds,
        activeBadge, notifyEnabled, avatarBase64, joinedAt
      FROM users
    ''');
    await db.execute('DROP TABLE users');
    await db.execute('ALTER TABLE users_new RENAME TO users');
  }

  Future<void> _seedDefaultUser() async {
    const defaultUsername = 'user@nusafauna.com';
    final existingUser = await _getUserFromDb(defaultUsername);
    if (existingUser == null) {
      final defaultProfile = UserProfile(
        username: defaultUsername,
        fullName: 'Ikbal NusaFauna',
        email: defaultUsername,
        password: 'password123',
        bio: 'Sangat mencintai keanekaragaman hayati Indonesia.',
        quizScores: const {},
        completedQuizzes: const [],
        earnedBadges: const [],
        viewedAnimalIds: const [],
        activeBadge: null,
        notifyEnabled: true,
      );
      await _db.insert(
        'users',
        defaultProfile.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
