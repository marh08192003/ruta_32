import '../models/department_model.dart';

final List<Department> allDepartments = [
  Department(
    id: 1,
    idCaida: 1,
    name: "Amazonas",
    assetPath: "assets/images/departments/dept_1.png",
  ),
  Department(
    id: 24,
    idCaida: 2,
    name: "Putumayo",
    assetPath: "assets/images/departments/dept_2.png",
  ),
  Department(
    id: 9,
    idCaida: 3,
    name: "Caquetá",
    assetPath: "assets/images/departments/dept_3.png",
  ),
  Department(
    id: 32,
    idCaida: 4,
    name: "Vaupés",
    assetPath: "assets/images/departments/dept_4.png",
  ),
  Department(
    id: 22,
    idCaida: 5,
    name: "Nariño",
    assetPath: "assets/images/departments/dept_5.png",
  ),
  Department(
    id: 17,
    idCaida: 6,
    name: "Guaviare",
    assetPath: "assets/images/departments/dept_6.png",
  ),
  Department(
    id: 11,
    idCaida: 7,
    name: "Cauca",
    assetPath: "assets/images/departments/dept_7.png",
  ),
  Department(
    id: 18,
    idCaida: 8,
    name: "Huila",
    assetPath: "assets/images/departments/dept_8.png",
  ),
  Department(
    id: 16,
    idCaida: 9,
    name: "Guainía",
    assetPath: "assets/images/departments/dept_9.png",
  ),
  Department(
    id: 21,
    idCaida: 10,
    name: "Meta",
    assetPath: "assets/images/departments/dept_10.png",
  ),
  Department(
    id: 31,
    idCaida: 11,
    name: "Valle del Cauca",
    assetPath: "assets/images/departments/dept_11.png",
  ),
  Department(
    id: 30,
    idCaida: 12,
    name: "Tolima",
    assetPath: "assets/images/departments/dept_12.png",
  ),
  Department(
    id: 33,
    idCaida: 13,
    name: "Vichada",
    assetPath: "assets/images/departments/dept_13.png",
  ),
  Department(
    id: 25,
    idCaida: 14,
    name: "Quindío",
    assetPath: "assets/images/departments/dept_14.png",
  ),
  Department(
    id: 26,
    idCaida: 15,
    name: "Risaralda",
    assetPath: "assets/images/departments/dept_15.png",
  ),
  Department(
    id: 8,
    idCaida: 16,
    name: "Caldas",
    assetPath: "assets/images/departments/dept_16.png",
  ),
  Department(
    id: 15,
    idCaida: 17,
    name: "Cundinamarca",
    assetPath: "assets/images/departments/dept_17.png",
  ),
  Department(
    id: 10,
    idCaida: 18,
    name: "Casanare",
    assetPath: "assets/images/departments/dept_18.png",
  ),
  Department(
    id: 7,
    idCaida: 19,
    name: "Boyacá",
    assetPath: "assets/images/departments/dept_19.png",
  ),
  Department(
    id: 13,
    idCaida: 20,
    name: "Chocó",
    assetPath: "assets/images/departments/dept_20.png",
  ),
  Department(
    id: 28,
    idCaida: 21,
    name: "Santander",
    assetPath: "assets/images/departments/dept_21.png",
  ),
  Department(
    id: 2,
    idCaida: 22,
    name: "Antioquia",
    assetPath: "assets/images/departments/dept_22.png",
  ),
  Department(
    id: 3,
    idCaida: 23,
    name: "Arauca",
    assetPath: "assets/images/departments/dept_23.png",
  ),
  Department(
    id: 23,
    idCaida: 24,
    name: "Norte de Santander",
    assetPath: "assets/images/departments/dept_24.png",
  ),
  Department(
    id: 14,
    idCaida: 25,
    name: "Córdoba",
    assetPath: "assets/images/departments/dept_25.png",
  ),
  Department(
    id: 6,
    idCaida: 26,
    name: "Bolívar",
    assetPath: "assets/images/departments/dept_26.png",
  ),
  Department(
    id: 12,
    idCaida: 27,
    name: "Cesar",
    assetPath: "assets/images/departments/dept_27.png",
  ),
  Department(
    id: 29,
    idCaida: 28,
    name: "Sucre",
    assetPath: "assets/images/departments/dept_28.png",
  ),
  Department(
    id: 20,
    idCaida: 29,
    name: "Magdalena",
    assetPath: "assets/images/departments/dept_29.png",
  ),
  Department(
    id: 19,
    idCaida: 30,
    name: "La Guajira",
    assetPath: "assets/images/departments/dept_30.png",
  ),
  Department(
    id: 4,
    idCaida: 31,
    name: "Atlántico",
    assetPath: "assets/images/departments/dept_31.png",
  ),
  Department(
    id: 27,
    idCaida: 32,
    name: "San Andrés y Providencia",
    assetPath: "assets/images/departments/dept_32.png",
  ),
];

Department getDepartmentByApiId(int apiId) {
  return allDepartments.firstWhere(
    (dept) => dept.id == apiId,
    orElse: () => allDepartments.first, // Un fallback por seguridad
  );
}
