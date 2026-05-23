# Checklist Kebutuhan Gambar - Aplikasi NusaFauna

Dokumen ini berisi daftar lengkap seluruh aset gambar lokal dan tautan gambar placeholder jaringan yang digunakan di dalam aplikasi **NusaFauna**. Anda dapat memanfaatkan checklist di bawah ini untuk menandai kesiapan aset rill Anda sebelum masuk ke tahap produksi rilis resmi.

---

## 📁 1. Aset Gambar Lokal (Direktori `assets/images/`)
Aset ini wajib diletakkan secara fisik di dalam folder proyek Anda di **`assets/images/`** dan terdaftar di `pubspec.yaml`.

- [ ] **`logo.png`**  
  *   **Deskripsi**: Logo resmi **NUSA FAUNA**. Ditampilkan pada halaman Login, Register, App Bar header setiap menu utama (Beranda, Satwa, Kuis, Lencana, Profil), dan Halaman Tentang Kami.  
  *   **Rekomendasi Dimensi**: `256 x 256 px` (Latar belakang transparan).
- [ ] **`Ic_mamalia.png`**  
  *   **Deskripsi**: Ikon representasi kategori **Mamalia**. Digunakan sebagai tombol filter kategori di menu Ensiklopedia dan ikon kategori di Beranda.  
  *   **Rekomendasi Dimensi**: `64 x 64 px` (Latar belakang transparan/warna putih solid).
- [ ] **`Ic_burung.png`**  
  *   **Deskripsi**: Ikon representasi kategori **Burung**. Digunakan sebagai tombol filter kategori di menu Ensiklopedia dan ikon kategori di Beranda.  
  *   **Rekomendasi Dimensi**: `64 x 64 px` (Latar belakang transparan/warna putih solid).
- [ ] **`Ic_reptil.png`**  
  *   **Deskripsi**: Ikon representasi kategori **Reptil**. Digunakan sebagai tombol filter kategori di menu Ensiklopedia dan ikon kategori di Beranda.  
  *   **Rekomendasi Dimensi**: `64 x 64 px` (Latar belakang transparan/warna putih solid).
- [ ] **`Ic_laut.png`**  
  *   **Deskripsi**: Ikon representasi kategori **Satwa Laut**. Digunakan sebagai tombol filter kategori di menu Ensiklopedia dan ikon kategori di Beranda.  
  *   **Rekomendasi Dimensi**: `64 x 64 px` (Latar belakang transparan/warna putih solid).

---

## 🐅 2. Gambar Ensiklopedia Satwa (Konfigurasi di `dummy_data.dart`)
Gambar-gambar berikut memvisualisasikan masing-masing spesies satwa liar di halaman **Ensiklopedia** dan **Detail Satwa**.

- [ ] **Harimau Sumatera** (`harimau_sumatera`)  
  *   **Kebutuhan Gambar**: Harimau sumatera loreng tebal di dalam hutan lebat.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1574068468008-723fe04f3250)
- [ ] **Komodo** (`komodo`)  
  *   **Kebutuhan Gambar**: Komodo besar dengan lidah menjulur di habitat sabana Flores/Komodo.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1603483080228-04f2313d9f10)
- [ ] **Orangutan Sumatera** (`orangutan`)  
  *   **Kebutuhan Gambar**: Orangutan berbulu kemerahan sedang bergantung di dahan pohon.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1540573133985-87b6da6d54a9)
- [ ] **Badak Jawa** (`badak_jawa`)  
  *   **Kebutuhan Gambar**: Badak jawa bercula satu yang berkulit tebal mirip baju zirah di dalam lumpur/semak.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1589656966895-2f33e7653819)
- [ ] **Cenderawasih Kuning Besar** (`cenderawasih`)  
  *   **Kebutuhan Gambar**: Burung surga cenderawasih memamerkan bulu kuning panjangnya yang anggun.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1616781296184-257a4128f731)
- [ ] **Gajah Sumatera** (`gajah_sumatera`)  
  *   **Kebutuhan Gambar**: Gajah sumatera berukuran sedang di dalam kawasan hutan hujan tropis Sumatera.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1581888227599-779811939961)
- [ ] **Anoa Dataran Rendah** (`anoa`)  
  *   **Kebutuhan Gambar**: Sapi/kerbau kerdil anoa khas Sulawesi dengan tanduk lurus ke belakang.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1549488344-1f9b8d2bd1f3)
- [ ] **Burung Maleo** (`maleo`)  
  *   **Kebutuhan Gambar**: Burung maleo khas dengan jambul kepala hitamnya di daerah pasir hangat pantai/vulkanik.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1518998053901-5348d3961a04)
- [ ] **Penyu Hijau** (`penyu_hijau`)  
  *   **Kebutuhan Gambar**: Penyu hijau sedang menyelam berenang di atas terumbu karang laut biru.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1591025207163-942350e47db2)
- [ ] **Enggang Gading** (`enggang_gading`)  
  *   **Kebutuhan Gambar**: Burung enggang berukuran besar dengan helm paruh yang kokoh merah/kuning cerah.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1607990283143-e81e7a2c93ab)
- [ ] **Jalak Bali** (`jalak_bali`)  
  *   **Kebutuhan Gambar**: Burung jalak bali berbulu putih bersih dengan kulit lingkaran biru di sekeliling mata.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1555041469-a586c61ea9bc)
- [ ] **Elang Jawa** (`elang_jawa`)  
  *   **Kebutuhan Gambar**: Elang jawa gagah berjambul hitam tegak (identik lambang negara Garuda).  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1611689342806-0863700ce1e4)
- [ ] **Hiu Paus** (`hiu_paus`)  
  *   **Kebutuhan Gambar**: Hiu paus berukuran raksasa dengan motif bintik putih berenang di perairan hangat tropis.  
  *   *Tautan Saat Ini*: [Unsplash Link](https://images.unsplash.com/photo-1560275669-46c5a89d7a44)

---

## 📝 3. Gambar Sampul Kuis (Menu Kuis)
Gambar-gambar berikut digunakan sebagai *thumbnail* dekoratif kategori kuis pada **Menu Kuis** utama dan kartu **Kuis Harian**.

- [ ] **Sampul Kuis Harian**  
  *   **Kebutuhan Gambar**: Lanskap hutan pagi yang asri tertutup embun tipis/kabut rimba.  
  *   *Tautan Saat Ini*: [Mist Forest](https://images.unsplash.com/photo-1502082553048-f009c37129b9)
- [ ] **Sampul Penjelajah Sumatra**  
  *   **Kebutuhan Gambar**: Harimau sumatera gagah/lanskap pegunungan Sumatra.  
  *   *Tautan Saat Ini*: [Sumatran Tiger](https://images.unsplash.com/photo-1561731216-c3a4d99437d5)
- [ ] **Sampul Mamalia Jawa**  
  *   **Kebutuhan Gambar**: Badak jawa atau pemandangan hutan tropis Jawa.  
  *   *Tautan Saat Ini*: [Javan Rhinoceros](https://images.unsplash.com/photo-1549488344-1f9b8d2bd1f3)
- [ ] **Sampul Pepohonan Kalimantan**  
  *   **Kebutuhan Gambar**: Lanskap sungai membelah rimba lebat Kalimantan / Orangutan.  
  *   *Tautan Saat Ini*: [Kalimantan Rainforest](https://images.unsplash.com/photo-1570481662006-a3a13746fe4e)
- [ ] **Sampul Dalam Bahaya**  
  *   **Kebutuhan Gambar**: Padang sabana kering eksotis/lanskap satwa yang terancam punah.  
  *   *Tautan Saat Ini*: [Endangered Habitat](https://images.unsplash.com/photo-1544551763-46a013bb70d5)
- [ ] **Sampul Bulu Indah Nusantara**  
  *   **Kebutuhan Gambar**: Gambar burung cenderawasih atau merak memamerkan ekornya yang indah.  
  *   *Tautan Saat Ini*: [Birds of Paradise](https://images.unsplash.com/photo-1555041469-a586c61ea9bc)

---

## 🏞️ 4. Gambar Peta Habitat & Wilayah (Halaman Detail Satwa)
Digunakan sebagai gambar latar belakang kartu **Peta Distribusi Satwa** di halaman detail satwa, menyesuaikan dengan asal wilayah aslinya.

- [ ] **Wilayah Nusa Tenggara (Komodo)**  
  *   **Kebutuhan Gambar**: Lanskap sabana bukit kering yang dramatis khas pulau Komodo/NTT.  
  *   *Tautan Saat Ini*: [Flores Savanna](https://images.unsplash.com/photo-1516483638261-f4dbaf036963)
- [ ] **Wilayah Sumatera**  
  *   **Kebutuhan Gambar**: Hutan pegunungan tropis berkabut tebat Sumatra.  
  *   *Tautan Saat Ini*: [Sumatra Rainforest](https://images.unsplash.com/photo-1506744038136-46273834b3fb)
- [ ] **Wilayah Papua**  
  *   **Kebutuhan Gambar**: Lanskap hutan belantara pegunungan berkabut papua yang asri.  
  *   *Tautan Saat Ini*: [Papua Forest Canopy](https://images.unsplash.com/photo-1447752875215-b2761acb3c5d)
- [ ] **Wilayah Kalimantan**  
  *   **Kebutuhan Gambar**: Aliran sungai berkelok membelah rimba tebal Kalimantan.  
  *   *Tautan Saat Ini*: [Kalimantan Jungle](https://images.unsplash.com/photo-1473448912268-2022ce9509d8)
- [ ] **Wilayah Satwa Laut**  
  *   **Kebutuhan Gambar**: Terumbu karang bawah laut tropis yang jernih disinari cahaya matahari.  
  *   *Tautan Saat Ini*: [Coral Reef Ocean](https://images.unsplash.com/photo-1544551763-46a013bb70d5)
- [ ] **Wilayah Bali**  
  *   **Kebutuhan Gambar**: Hamparan sawah terasering subak hijau segar Bali.  
  *   *Tautan Saat Ini*: [Bali Greenery](https://images.unsplash.com/photo-1537996194471-e657df975ab4)
- [ ] **Wilayah Jawa**  
  *   **Kebutuhan Gambar**: Siluet jajaran gunung berapi aktif di Jawa berlatar matahari terbit.  
  *   *Tautan Saat Ini*: [Javan Volcanos](https://images.unsplash.com/photo-1464822759023-fed622ff2c3b)
- [ ] **Lainnya / Umum**  
  *   **Kebutuhan Gambar**: Lanskap padang rumput atau vegetasi hijau alam liar Indonesia.  
  *   *Tautan Saat Ini*: [Generic Greenery](https://images.unsplash.com/photo-1441974231531-c6227db76b6e)

---

## 👤 5. Gambar Dekoratif Antarmuka (UI & Profil)
Gambar ini digunakan untuk pemanis antarmuka, halaman statis, atau profil bawaan.

- [ ] **Foto Profil Default Pengguna**  
  *   **Kebutuhan Gambar**: Avatar minimalis berkarakter ceria (pria/wanita) dengan latar belakang warna pastel bersih.  
  *   *Tautan Saat Ini*: [Default Avatar](https://images.unsplash.com/photo-1535713875002-d1d0cf377fde)
- [ ] **Hero Banner Beranda**  
  *   **Kebutuhan Gambar**: Pemandangan panorama keindahan alam pegunungan Indonesia yang megah dan asri.  
  *   *Tautan Saat Ini*: [Home Hero Nature](https://images.unsplash.com/photo-1511497584788-876760111969)
- [ ] **Hero Banner Halaman Tentang Kami**  
  *   **Kebutuhan Gambar**: Deretan pohon pinus/hutan rimba disinari hangat sinar fajar terbit pagi.  
  *   *Tautan Saat Ini*: [About Us Jungle Dawn](https://images.unsplash.com/photo-1448375240586-882707db888b)

---

> 💡 **Tips Penggantian**: Jika ingin aplikasi sepenuhnya berjalan tanpa internet (*offline-first*), unduh semua gambar yang Anda inginkan, masukkan ke folder `assets/images/`, daftarkan di berkas `pubspec.yaml`, lalu ganti pemanggilan kelas widget `Image.network(...)` menjadi `Image.asset(...)` pada file DART yang bersangkutan.
