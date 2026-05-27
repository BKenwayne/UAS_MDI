# NusaFauna

**NusaFauna** adalah aplikasi edukasi interaktif berbasis mobile yang dikembangkan menggunakan **Flutter**. Aplikasi ini bertujuan untuk meningkatkan kesadaran, wawasan, dan kepedulian masyarakat terhadap keanekaragaman hayati dan satwa endemik di Indonesia, khususnya satwa-satwa yang berstatus dilindungi dan terancam punah.

## Fitur Utama

- **Ensiklopedia Satwa (Encyclopedia):** Menampilkan direktori lengkap hewan endemik Indonesia (seperti Harimau Sumatera, Komodo, Orangutan, Badak Jawa, Burung Cenderawasih, dll). Setiap profil satwa dilengkapi dengan nama latin, deskripsi, habitat, status konservasi, dan fakta unik.
- **Kuis Edukatif (Interactive Quizzes):** Berbagai kategori kuis menarik (Penjelajah Sumatra, Mamalia Jawa, Dalam Bahaya, Kuis Harian, dll) untuk menguji pengetahuan pengguna tentang satwa nusantara.
- **Sistem Lencana & Gamifikasi (Badges System):** Pengguna bisa mendapatkan lencana kebanggaan (seperti *Ahli Sumatra*, *Pelindung Satwa*, *Pakar Burung*, dll) apabila berhasil menyelesaikan kuis dengan nilai batas lulus tertentu.
- **Profil Pengguna (User Profile):** Sistem manajemen profil pengguna di mana pengguna dapat mendaftar, masuk, serta mengedit profil dan bio. Kemajuan belajar, lencana yang diperoleh, dan skor kuis disimpan dan direkam secara dinamis.
- **Database Lokal Offline (SQLite):** Aplikasi sepenuhnya mendukung fungsionalitas *offline*. Semua data kemajuan kuis, profil, preferensi, dan informasi otentikasi disimpan dengan aman secara lokal menggunakan integrasi database **SQLite** (melalui `sqflite`) dan `SharedPreferences`.

## Teknologi yang Digunakan

* **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.10.8)
* **Bahasa Pemrograman:** Dart
* **Penyimpanan Lokal:** 
  * `sqflite` untuk relational SQL database (menyimpan data User Profiles secara persisten).
  * `shared_preferences` untuk manajemen sesi login yang cepat.

## Cara Menjalankan Aplikasi (Lokal)

Pastikan komputer Anda sudah terinstal SDK Flutter dan Android Studio/VS Code.
1. Klon repositori ini atau ekstrak folder project.
2. Buka terminal di direktori root aplikasi.
3. Unduh semua dependensi dengan perintah:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi pada perangkat atau emulator yang terhubung:
   ```bash
   flutter run
   ```

