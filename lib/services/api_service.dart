import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api-colombia.com/api/v1';

  // 1. Traer platos típicos por ID de departamento
  Future<List<Map<String, dynamic>>> getTypicalDishes(int departmentId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/TypicalDish/$departmentId/department'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar platos típicos');
    }
  }

  // 2. Traer patrimonio inmaterial
  Future<List<Map<String, dynamic>>> getHeritage(int departmentId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/IntangibleHeritage/$departmentId/department'),
    );

    if (response.statusCode == 200) {
      // Nota: A veces la API devuelve una lista o un objeto simple,
      // verificamos según lo que viste en tus curl.
      final data = json.decode(response.body);
      if (data is List) return data.cast<Map<String, dynamic>>();
      return [data as Map<String, dynamic>];
    }
    return [];
  }

  // 3. Traer detalle extra del departamento (población, superficie, etc.)
  Future<Map<String, dynamic>> getDepartmentDetails(int departmentId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/Department/$departmentId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar detalle del departamento');
    }
  }
}
