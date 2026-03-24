class Department {
  final int id;
  final String name;
  final String description;
  final int cityCount;
  final double latitude; // La usaremos para el orden de "caída"

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.cityCount,
    required this.latitude,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      cityCount: json['cityCount'] ?? 0,
      // Nota: Asignaremos latitudes reales en el servicio
      latitude: 0.0,
    );
  }
}
