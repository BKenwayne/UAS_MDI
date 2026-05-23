class Animal {
  final String id;
  final String name;
  final String latinName;
  final String category; // e.g., 'Mamalia', 'Burung', 'Reptil'
  final String description;
  final String habitat;
  final String status; // e.g., 'Dilindungi', 'Rentan', 'Kritis'
  final String funFact;
  final String imageUrl;

  const Animal({
    required this.id,
    required this.name,
    required this.latinName,
    required this.category,
    required this.description,
    required this.habitat,
    required this.status,
    required this.funFact,
    required this.imageUrl,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] as String,
      name: json['name'] as String,
      latinName: json['latinName'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      habitat: json['habitat'] as String,
      status: json['status'] as String,
      funFact: json['funFact'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latinName': latinName,
      'category': category,
      'description': description,
      'habitat': habitat,
      'status': status,
      'funFact': funFact,
      'imageUrl': imageUrl,
    };
  }
}
