class Department {
  final int id; // ID API-Colombia (ej: Valle del Cauca es 31)
  final int
  idCaida; // ID de lógica de juego (1 al 32; ej: Valle del Cauca es 11)
  final String name;
  final String assetPath;

  final String? description;
  final int? population;
  final int? surface;

  Department({
    required this.id,
    required this.idCaida,
    required this.name,
    required this.assetPath,
    this.description,
    this.population,
    this.surface,
  });

  factory Department.fromJson(
    Map<String, dynamic> json,
    int idCaida,
    String asset,
  ) {
    return Department(
      id: json['id'],
      idCaida: idCaida,
      name: json['name'],
      assetPath: asset,
      description: json['description'],
      population: json['population'],
      surface: json['surface'],
    );
  }
}
