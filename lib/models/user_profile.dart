import 'dart:convert';

class UserProfile {
  final String username;
  final String fullName;
  final String email;
  final String password;
  final String bio;
  final Map<String, int> quizScores; // Map of categoryId -> high score
  final List<String> completedQuizzes; // List of completed categoryIds
  final List<String> earnedBadges; // List of earned badge names
  final List<String> viewedAnimalIds; // List of viewed animal IDs for dynamic stats
  final String? activeBadge; // Currently equipped badge name
  final bool notifyEnabled;
  final String? avatarBase64;
  final String? joinedAt;

  const UserProfile({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
    required this.bio,
    required this.quizScores,
    required this.completedQuizzes,
    required this.earnedBadges,
    required this.viewedAnimalIds,
    this.activeBadge,
    required this.notifyEnabled,
    this.avatarBase64,
    this.joinedAt,
  });

  String get displayName => fullName.isNotEmpty ? fullName : username.split('@')[0];

  UserProfile copyWith({
    String? username,
    String? fullName,
    String? email,
    String? password,
    String? bio,
    Map<String, int>? quizScores,
    List<String>? completedQuizzes,
    List<String>? earnedBadges,
    List<String>? viewedAnimalIds,
    String? activeBadge,
    bool clearActiveBadge = false,
    bool? notifyEnabled,
    String? avatarBase64,
    String? joinedAt,
  }) {
    return UserProfile(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      bio: bio ?? this.bio,
      quizScores: quizScores ?? this.quizScores,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      viewedAnimalIds: viewedAnimalIds ?? this.viewedAnimalIds,
      activeBadge: clearActiveBadge ? null : (activeBadge ?? this.activeBadge),
      notifyEnabled: notifyEnabled ?? this.notifyEnabled,
      avatarBase64: avatarBase64 ?? this.avatarBase64,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] as String,
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      quizScores: Map<String, int>.from(json['quizScores'] as Map? ?? {}),
      completedQuizzes: List<String>.from(json['completedQuizzes'] as Iterable? ?? []),
      earnedBadges: List<String>.from(json['earnedBadges'] as Iterable? ?? []),
      viewedAnimalIds: List<String>.from(json['viewedAnimalIds'] as Iterable? ?? []),
      activeBadge: json['activeBadge'] as String?,
      notifyEnabled: json['notifyEnabled'] as bool? ?? true,
      avatarBase64: json['avatarBase64'] as String?,
      joinedAt: json['joinedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'password': password,
      'bio': bio,
      'quizScores': quizScores,
      'completedQuizzes': completedQuizzes,
      'earnedBadges': earnedBadges,
      'viewedAnimalIds': viewedAnimalIds,
      'activeBadge': activeBadge,
      'notifyEnabled': notifyEnabled,
      'avatarBase64': avatarBase64,
      'joinedAt': joinedAt,
    };
  }

  factory UserProfile.initial(String username) {
    return UserProfile(
      username: username,
      fullName: '',
      email: '',
      password: '',
      bio: '',
      quizScores: const {},
      completedQuizzes: const [],
      earnedBadges: const [],
      viewedAnimalIds: const [],
      activeBadge: null,
      notifyEnabled: true,
      avatarBase64: null,
      joinedAt: null,
    );
  }

  Map<String, dynamic> toDbMap() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'password': password,
      'bio': bio,
      'quizScores': jsonEncode(quizScores),
      'completedQuizzes': jsonEncode(completedQuizzes),
      'earnedBadges': jsonEncode(earnedBadges),
      'viewedAnimalIds': jsonEncode(viewedAnimalIds),
      'activeBadge': activeBadge,
      'notifyEnabled': notifyEnabled ? 1 : 0,
      'avatarBase64': avatarBase64,
      'joinedAt': joinedAt,
    };
  }

  factory UserProfile.fromDbMap(Map<String, dynamic> map) {
    return UserProfile(
      username: map['username'] as String,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      bio: map['bio'] as String? ?? '',
      quizScores: Map<String, int>.from(jsonDecode(map['quizScores'] as String? ?? '{}')),
      completedQuizzes: List<String>.from(jsonDecode(map['completedQuizzes'] as String? ?? '[]')),
      earnedBadges: List<String>.from(jsonDecode(map['earnedBadges'] as String? ?? '[]')),
      viewedAnimalIds: List<String>.from(jsonDecode(map['viewedAnimalIds'] as String? ?? '[]')),
      activeBadge: map['activeBadge'] as String?,
      notifyEnabled: (map['notifyEnabled'] as int? ?? 1) == 1,
      avatarBase64: map['avatarBase64'] as String?,
      joinedAt: map['joinedAt'] as String?,
    );
  }
}
