import '../models/animal.dart';
import '../models/quiz.dart';

class DummyData {
  static const List<Animal> animals = [
    Animal(
      id: 'harimau_sumatera',
      name: 'Harimau Sumatera',
      latinName: 'Panthera tigris sumatrae',
      category: 'Mamalia',
      description: 'Harimau Sumatera adalah subspesies harimau terkecil yang masih hidup di dunia. Mereka memiliki warna kulit paling gelap di antara semua harimau, dengan pola loreng hitam tebal yang rapat, membantu mereka berkamuflase dengan sangat baik di hutan hujan lebat Sumatera.',
      habitat: 'Hutan hujan tropis, dataran rendah, dan lahan gambut di Pulau Sumatera.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Harimau Sumatera adalah satu-satunya subspesies harimau yang masih tersisa di Indonesia, setelah Harimau Bali dan Harimau Jawa dinyatakan punah.',
      imageUrl: 'assets/images/satwa/harimau_sumatera.jpeg',
    ),
    Animal(
      id: 'komodo',
      name: 'Komodo',
      latinName: 'Varanus komodoensis',
      category: 'Reptil',
      description: 'Komodo adalah spesies kadal terbesar dan terberat di dunia. Sebagai predator puncak di habitat aslinya, komodo menggunakan indra penciumannya yang tajam (melalui lidah bercabang) dan air liur berbisa untuk melumpuhkan mangsa berukuran besar seperti rusa atau kerbau.',
      habitat: 'Padang rumput kering (sabana) dan hutan gugur di Pulau Komodo, Rinca, Flores, Gili Motang, dan Padar di Nusa Tenggara Timur.',
      status: 'Terancam (Endangered)',
      funFact: 'Air liur komodo mengandung kelenjar racun yang dapat mencegah pembekuan darah mangsa, menyebabkan pendarahan terus-menerus dan syok.',
      imageUrl: 'assets/images/satwa/komodo.jpg',
    ),
    Animal(
      id: 'orangutan',
      name: 'Orangutan Sumatera',
      latinName: 'Pongo abelii',
      category: 'Mamalia',
      description: 'Orangutan adalah salah satu primata paling cerdas di dunia. Mereka menghabiskan hampir seluruh hidup mereka di atas pohon (arboreal). Orangutan Sumatera dikenal memiliki rambut kemerahan yang lebih terang dan perilaku sosial yang sedikit berbeda dibandingkan Orangutan Kalimantan.',
      habitat: 'Kanopi hutan hujan tropis primer di wilayah utara Pulau Sumatera.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Nama "Orangutan" berasal dari bahasa Melayu/Indonesia yang secara harfiah berarti "Orang dari hutan".',
      imageUrl: 'assets/images/satwa/orangutan_sumatera.jpg',
    ),
    Animal(
      id: 'badak_jawa',
      name: 'Badak Jawa',
      latinName: 'Rhinoceros sondaicus',
      category: 'Mamalia',
      description: 'Badak Jawa merupakan salah satu mamalia besar terlangka di dunia. Hewan soliter berkulit tebal bermotif mosaik mirip baju zirah ini hanya memiliki satu cula (terutama jantan), tidak seperti sepupunya di Sumatera yang bercula dua.',
      habitat: 'Hutan hujan dataran rendah yang sangat lebat dan memiliki banyak kubangan air. Saat ini hanya ditemukan di Taman Nasional Ujung Kulon, Banten.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Badak Jawa jantan memiliki cula kecil berukuran hanya 20-25 cm, sedangkan badak betina biasanya tidak bercula sama sekali.',
      imageUrl: 'assets/images/satwa/badak_jawa.jpeg',
    ),
    Animal(
      id: 'cenderawasih',
      name: 'Cenderawasih Kuning Besar',
      latinName: 'Paradisaea apoda',
      category: 'Burung',
      description: 'Dijuluki sebagai "Bird of Paradise" (Burung Surga), cenderawasih terkenal karena keindahan bulu hiasan jantan yang luar biasa indah dengan tarian kawinnya yang anggun dan ritmis untuk memikat betina di atas tajuk pohon.',
      habitat: 'Hutan dataran rendah dan perbukitan di Pulau Papua dan Kepulauan Aru.',
      status: 'Dilindungi (Protected)',
      funFact: 'Pada zaman dulu, bangsa Eropa percaya burung ini tidak berkaki dan terus terbang di surga tanpa pernah mendarat, karena spesimen yang mereka terima kakinya telah dipotong.',
      imageUrl: 'assets/images/satwa/cendrawasih_kb.jpg',
    ),
    Animal(
      id: 'gajah_sumatera',
      name: 'Gajah Sumatera',
      latinName: 'Elephas maximus sumatranus',
      category: 'Mamalia',
      description: 'Gajah Sumatera adalah subspesies dari gajah Asia yang berukuran paling kecil. Mereka memiliki peran ekologi yang sangat penting karena menyebarkan benih tanaman hutan melalui kotorannya, membantu menjaga keseimbangan ekosistem hutan hujan.',
      habitat: 'Hutan tropis dataran rendah dan kawasan rawa di Pulau Sumatera.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Gajah Sumatera memiliki 20 pasang tulang rusuk, sementara gajah Asia lainnya umumnya memiliki 19 pasang.',
      imageUrl: 'assets/images/satwa/gajah_sumatera.jpg',
    ),
    Animal(
      id: 'anoa',
      name: 'Anoa Dataran Rendah',
      latinName: 'Bubalus depressicornis',
      category: 'Mamalia',
      description: 'Anoa adalah hewan endemik Pulau Sulawesi yang sering dijuluki "Kerbau Kerdil". Meskipun menyerupai sapi atau kerbau kecil, anoa memiliki perilaku yang liar dan soliter di dalam rimba belantara.',
      habitat: 'Hutan hujan tropis primer, rawa, dan daerah pegunungan yang tenang di Pulau Sulawesi dan Pulau Buton.',
      status: 'Terancam (Endangered)',
      funFact: 'Anoa memiliki tanduk runcing berbentuk segitiga yang lurus ke belakang, yang mereka gunakan untuk mempertahankan diri dari predator atau menembus semak belukar lebat.',
      imageUrl: 'assets/images/satwa/anoa.jpg',
    ),
    Animal(
      id: 'maleo',
      name: 'Burung Maleo',
      latinName: 'Macrocephalon maleo',
      category: 'Burung',
      description: 'Maleo adalah burung endemik Sulawesi yang sangat unik. Burung berukuran sebesar ayam ini tidak mengerami telurnya dengan kehangatan tubuhnya sendiri, melainkan menguburnya di dalam pasir hangat vulkanik atau pantai untuk dihangatkan oleh bumi.',
      habitat: 'Hutan hujan tropis dekat daerah geothermal (vulkanik) dan pantai berpasir hangat di Pulau Sulawesi dan Buton.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Ukuran telur burung Maleo sangat besar, berkisar 5 kali lipat dari ukuran telur ayam biasa. Setelah menetas di bawah pasir, anak Maleo langsung sanggup terbang!',
      imageUrl: 'assets/images/satwa/maleo.jpg',
    ),
    Animal(
      id: 'penyu_hijau',
      name: 'Penyu Hijau',
      latinName: 'Chelonia mydas',
      category: 'Satwa Laut',
      description: 'Penyu Hijau adalah salah satu penyu laut besar yang terancam punah. Mereka memakan lamun dan alga untuk menjaga kesehatan ekosistem laut.',
      habitat: 'Perairan hangat tropis dan daerah terumbu karang di Indonesia.',
      status: 'Dilindungi (Protected)',
      funFact: 'Penyu Hijau bernapas menggunakan paru-paru, namun mereka sanggup menyelam di bawah air hingga 5 jam tanpa bernapas!',
      imageUrl: 'assets/images/satwa/penyu_hijau.jpg',
    ),
    Animal(
      id: 'enggang_gading',
      name: 'Enggang Gading',
      latinName: 'Rhinoplax vigil',
      category: 'Burung',
      description: 'Enggang Gading adalah burung berukuran besar dari keluarga Bucerotidae. Burung ini terkenal karena paruhnya yang kokoh mirip gading yang bernilai tinggi.',
      habitat: 'Hutan hujan dataran rendah di Kalimantan Barat dan Sumatera.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Tidak seperti enggang lainnya yang paruhnya berongga, Enggang Gading memiliki helm paruh yang padat berisi kalsium keras.',
      imageUrl: 'assets/images/satwa/enggang_gading.jpg',
    ),
    Animal(
      id: 'jalak_bali',
      name: 'Jalak Bali',
      latinName: 'Leucopsar rothschildi',
      category: 'Burung',
      description: 'Jalak Bali adalah sejenis burung pengicau berukuran sedang dengan bulu putih bersih di seluruh tubuhnya kecuali ujung sayap dan ekor yang hitam.',
      habitat: 'Hutan musim dataran rendah di wilayah barat laut Pulau Bali.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Jalak Bali memiliki kulit biru tua tanpa bulu di sekitar matanya yang membuatnya tampak sangat unik dan menawan.',
      imageUrl: 'assets/images/satwa/jalak_bali.jpg',
    ),
    Animal(
      id: 'elang_jawa',
      name: 'Elang Jawa',
      latinName: 'Nisaetus bartelsi',
      category: 'Burung',
      description: 'Elang Jawa adalah salah satu spesies elang berukuran sedang yang endemik di Pulau Jawa. Spesies ini dinilai sangat identik dengan lambang negara Indonesia, Garuda.',
      habitat: 'Hutan hujan tropis dataran tinggi dan pegunungan di Pulau Jawa.',
      status: 'Kritis (Critically Endangered)',
      funFact: 'Elang Jawa memiliki jambul menonjol di kepalanya yang berwarna hitam dengan panjang sekitar 12 cm.',
      imageUrl: 'assets/images/satwa/elang_jawa.jpg',
    ),
    Animal(
      id: 'hiu_paus',
      name: 'Hiu Paus',
      latinName: 'Rhincodon typus',
      category: 'Satwa Laut',
      description: 'Hiu Paus adalah spesies ikan terbesar di dunia. Meskipun berukuran raksasa, hiu ini sangat jinak dan hanya memakan plankton kecil serta ikan-ikan kecil.',
      habitat: 'Perairan samudera tropis yang hangat di seluruh Indonesia.',
      status: 'Dilindungi (Protected)',
      funFact: 'Pola bintik-bintik putih di punggung Hiu Paus bersifat unik layaknya sidik jari manusia; tidak ada dua Hiu Paus dengan pola bintik yang sama!',
      imageUrl: 'assets/images/satwa/hiu_paus.jpg',
    ),
  ];

  static const List<QuizCategory> quizzes = [
    QuizCategory(
      id: 'sumatra',
      title: 'Penjelajah Sumatra',
      description: 'Jelajahi wawasanmu tentang fauna megah Sumatra seperti Harimau, Gajah, dan Orangutan.',
      iconName: 'pets',
      passingScore: 75,
      badgeName: 'Ahli Sumatra',
      questions: [
        Question(
          id: 's1',
          questionText: 'Subspesies harimau apa di Indonesia yang saat ini masih hidup?',
          options: [
            'Harimau Bali',
            'Harimau Jawa',
            'Harimau Sumatera',
            'Harimau Kalimantan'
          ],
          correctOptionIndex: 2,
        ),
        Question(
          id: 's2',
          questionText: 'Apa keunikan fisik utama Gajah Sumatra dibanding gajah lainnya?',
          options: [
            'Memiliki 20 pasang tulang rusuk',
            'Telinganya raksasa mirip Gajah Afrika',
            'Tidak memiliki belalai',
            'Memiliki warna pink'
          ],
          correctOptionIndex: 0,
        ),
        Question(
          id: 's3',
          questionText: 'Manakah daerah konservasi utama Gajah di Sumatra?',
          options: [
            'Ujung Kulon',
            'Way Kambas',
            'Tanjung Puting',
            'Bunaken'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 's4',
          questionText: 'Mamalia terbang berukuran besar yang suka memakan buah di Sumatera dan Jawa adalah...',
          options: [
            'Kalong Raksasa',
            'Burung Hantu',
            'Kelelawar Vampir',
            'Tupai Terbang'
          ],
          correctOptionIndex: 0,
        ),
        Question(
          id: 's5',
          questionText: 'Hutan hujan tropis di Sumatera bagian utara yang menjadi situs warisan dunia UNESCO adalah...',
          options: [
            'Taman Nasional Komodo',
            'Taman Nasional Bunaken',
            'Taman Nasional Gunung Leuser',
            'Taman Nasional Bali Barat'
          ],
          correctOptionIndex: 2,
        ),
      ],
    ),
    QuizCategory(
      id: 'jawa',
      title: 'Mamalia Jawa',
      description: 'Seberapa kenal kamu dengan satwa langka Pulau Jawa seperti Badak Jawa dan Elang Jawa?',
      iconName: 'nature_people',
      passingScore: 75,
      badgeName: 'Pakar Jawa',
      questions: [
        Question(
          id: 'j1',
          questionText: 'Di taman nasional manakah habitat terakhir Badak Jawa saat ini?',
          options: [
            'Taman Nasional Way Kambas',
            'Taman Nasional Ujung Kulon',
            'Taman Nasional Gunung Gede',
            'Taman Nasional Bali Barat'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'j2',
          questionText: 'Burung pemangsa langka yang identik dengan lambang negara Garuda adalah...',
          options: [
            'Elang Jawa',
            'Rajawali Papua',
            'Elang Bondol',
            'Alap-alap Sapi'
          ],
          correctOptionIndex: 0,
        ),
        Question(
          id: 'j3',
          questionText: 'Berapakah jumlah cula yang dimiliki oleh Badak Jawa dewasa?',
          options: [
            'Dua cula',
            'Satu cula',
            'Tiga cula',
            'Tidak memiliki cula'
          ],
          correctOptionIndex: 1,
        ),
      ],
    ),
    QuizCategory(
      id: 'kalimantan',
      title: 'Pepohonan Kalimantan',
      description: 'Masuki rimbunnya hutan hujan Kalimantan dan uji pengetahuanmu tentang Orangutan.',
      iconName: 'park',
      passingScore: 75,
      badgeName: 'Ksatria Kalimantan',
      questions: [
        Question(
          id: 'k1',
          questionText: 'Apa arti harfiah dari kata "Orangutan"?',
          options: [
            'Kera berbulu merah',
            'Orang dari hutan',
            'Penjaga rimba raya',
            'Primata cerdas'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'k2',
          questionText: 'Burung maskot Kalimantan yang memiliki paruh besar melengkung ke atas adalah...',
          options: [
            'Cenderawasih',
            'Burung Enggang Gading',
            'Maleo',
            'Jalak Bali'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'k3',
          questionText: 'Apa pakan utama Orangutan di alam liar?',
          options: [
            'Daging hewan kecil',
            'Buah-buahan hutan',
            'Serangga tanah',
            'Ikan sungai'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'k4',
          questionText: 'Orangutan di Kalimantan dikelompokkan ke dalam genus primata apa?',
          options: [
            'Pan',
            'Gorilla',
            'Pongo',
            'Macaca'
          ],
          correctOptionIndex: 2,
        ),
        Question(
          id: 'k5',
          questionText: 'Kera berhidung panjang dan besar yang endemik di hutan bakau Kalimantan adalah...',
          options: [
            'Bekantan',
            'Lutung',
            'Owa Jawa',
            'Siamang'
          ],
          correctOptionIndex: 0,
        ),
        Question(
          id: 'k6',
          questionText: 'Mamalia air tawar langka mirip lumba-lumba yang hidup di Sungai Mahakam adalah...',
          options: [
            'Pesut Mahakam',
            'Dugong',
            'Lumba-lumba Hidung Botol',
            'Paus Sperma'
          ],
          correctOptionIndex: 0,
        ),
      ],
    ),
    QuizCategory(
      id: 'bahaya',
      title: 'Dalam Bahaya',
      description: 'Uji wawasanmu tentang kadal purba Komodo dan hewan yang kritis terancam punah.',
      iconName: 'warning_amber_rounded',
      passingScore: 75,
      badgeName: 'Pelindung Satwa',
      questions: [
        Question(
          id: 'd1',
          questionText: 'Kadal terbesar dan terberat di dunia yang hidup di Nusa Tenggara Timur adalah...',
          options: [
            'Biawak Air',
            'Komodo',
            'Iguana Hijau',
            'Tokek Raksasa'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'd2',
          questionText: 'Hewan endemik Sulawesi berukuran kerdil yang mirip dengan kerbau adalah...',
          options: [
            'Tapir',
            'Anoa',
            'Babirusa',
            'Bekantan'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'd3',
          questionText: 'Mengapa air liur Komodo sangat berbahaya bagi mangsa yang digigitnya?',
          options: [
            'Mengandung kelenjar bisa anti-pembekuan darah',
            'Mengandung zat asam korosif',
            'Mengandung racun pembeku darah',
            'Sangat panas bagaikan api'
          ],
          correctOptionIndex: 0,
        ),
        Question(
          id: 'd4',
          questionText: 'Burung endemik Sulawesi yang bertelur di pasir hangat dan langsung terbang saat menetas adalah...',
          options: [
            'Burung Maleo',
            'Burung Cenderawasih',
            'Kakatua Jambul Kuning',
            'Rangkong'
          ],
          correctOptionIndex: 0,
        ),
      ],
    ),
    QuizCategory(
      id: 'burung',
      title: 'Bulu Indah Nusantara',
      description: 'Jelajahi keindahan burung-burung surgawi khas nusantara seperti Cenderawasih.',
      iconName: 'egg',
      passingScore: 75,
      badgeName: 'Pakar Burung',
      questions: [
        Question(
          id: 'b1',
          questionText: 'Burung apakah yang dijuluki sebagai "Bird of Paradise" karena keindahan bulunya?',
          options: [
            'Burung Maleo',
            'Burung Cenderawasih',
            'Jalak Bali',
            'Burung Merak'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'b2',
          questionText: 'Burung endemik pulau Bali yang seluruh bulunya putih bersih dengan lingkaran biru di mata adalah...',
          options: [
            'Maleo',
            'Jalak Bali',
            'Cenderawasih',
            'Elang Jawa'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'b3',
          questionText: 'Bagaimana cara unik Burung Maleo menetaskan telurnya yang sangat besar?',
          options: [
            'Dierami induk bergantian',
            'Dikubur di dalam pasir hangat vulkanik/pantai',
            'Dititipkan pada sarang burung lain',
            'Diletakkan di pucuk pohon'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'b4',
          questionText: 'Burung merak hijau yang terkenal indah saat mengembangkan ekornya hidup di pulau...',
          options: [
            'Kalimantan',
            'Sumatera',
            'Jawa',
            'Sulawesi'
          ],
          correctOptionIndex: 2,
        ),
        Question(
          id: 'b5',
          questionText: 'Satwa maskot provinsi DKI Jakarta yang merupakan burung pemangsa gagah adalah...',
          options: [
            'Elang Bondol',
            'Elang Jawa',
            'Kakatua',
            'Merpati'
          ],
          correctOptionIndex: 0,
        ),
      ],
    ),
    QuizCategory(
      id: 'harian',
      title: 'Kuis Harian: Misteri Rimba',
      description: 'Asah wawasan satwamu setiap hari dengan menjawab pertanyaan misteri hutan nusantara!',
      iconName: 'calendar_today_rounded',
      passingScore: 60,
      badgeName: 'Penjelajah Harian',
      questions: [
        Question(
          id: 'h1',
          questionText: 'Spesies ikan terbesar di dunia yang jinak dan menyukai perairan tropis Indonesia adalah...',
          options: [
            'Hiu Putih Besar',
            'Hiu Paus',
            'Pari Manta',
            'Paus Biru'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'h2',
          questionText: 'Di pulau manakah habitat utama bagi kadal purba raksasa Komodo berada?',
          options: [
            'Pulau Jawa',
            'Pulau NTT (Pulau Komodo, Rinca, dll)',
            'Pulau Sumatra',
            'Pulau Kalimantan'
          ],
          correctOptionIndex: 1,
        ),
        Question(
          id: 'h3',
          questionText: 'Hewan langka manakah yang memiliki belang unik menyerupai sidik jari pada manusia?',
          options: [
            'Gajah Sumatra',
            'Harimau Sumatra',
            'Badak Jawa',
            'Orangutan'
          ],
          correctOptionIndex: 1,
        ),
      ],
    ),
  ];
}
