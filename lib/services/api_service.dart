import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/department_model.dart';

class ApiService {
  final String baseUrl = "https://api-colombia.com/api/v1";

  Future<List<Department>> getDepartments() async {
    final response = await http.get(Uri.parse('$baseUrl/Department'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      // Mapeamos y aquí podrías inyectar una lista de latitudes predefinidas
      // para asegurar el orden de sur a norte.
      List<Department> deps = body
          .map((dynamic item) => Department.fromJson(item))
          .toList();

      // Ejemplo de lógica de ordenamiento manual o por ID si la API es consistente
      // Para el MVP, podemos ordenar por una lista de IDs que tú definas (Sur -> Norte)
      return _sortDepartmentsSouthToNorth(deps);
    } else {
      throw Exception('Failed to load departments');
    }
  }

  List<Department> _sortDepartmentsSouthToNorth(List<Department> list) {
    // Aquí definiremos el orden específico (Amazonas, Putumayo, etc.)
    // Por ahora, retornamos la lista.
    return list;
  }
}
