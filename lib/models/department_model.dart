class Department {
  final int id; // ID API-Colombia (ej: Valle del Cauca es 31)
  final int
  idCaida; // ID de lógica de juego (1 al 32; ej: Valle del Cauca es 11)
  final String name;
  final String assetPath;
  final String? region;

  final String? description;
  final int? population;
  final int? surface;
  final String? capitalName;
  final String? capitalDescription;

  Department({
    required this.id,
    required this.idCaida,
    required this.name,
    required this.assetPath,
    this.region,
    this.description,
    this.population,
    this.surface,
    this.capitalName,
    this.capitalDescription,
  });

  String get selectionImage =>
      assetPath.replaceFirst('departments/', 'selection/');
  String get detailImage => assetPath.replaceFirst('departments/', 'detail/');
  String get gameImage => assetPath;

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
