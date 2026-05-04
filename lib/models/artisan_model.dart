class ArtisanModel {
  final int id;
  final String name;
  final String specialty;
  final double rating;
  final String location;
  final bool isAvailable;

  ArtisanModel({
    required this.id,
    required this.name,
    required this.specialty,
    this.rating = 0.0,
    required this.location,
    this.isAvailable = true,
  });

  // Cette fonction transforme ton JSON Laravel en objet Flutter
  factory ArtisanModel.fromJson(Map<String, dynamic> json) {
    return ArtisanModel(
      id: json['id'],
      name: json['user']['name'], // On va chercher le nom dans l'objet 'user'
      specialty: json['category']['name'], // On va chercher le nom dans 'category'
      location: json['base_location'] ?? 'Lieu non défini',
      isAvailable: json['is_available'] == 1,
    );
  }
}