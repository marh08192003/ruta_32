import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department_model.dart';
import '../services/api_service.dart';

final departmentCacheProvider =
    NotifierProvider<DepartmentCacheNotifier, Map<int, Department>>(
      DepartmentCacheNotifier.new,
    );

class DepartmentCacheNotifier extends Notifier<Map<int, Department>> {
  @override
  Map<int, Department> build() {
    // Estado inicial: un mapa vacío
    return {};
  }

  final ApiService _apiService = ApiService();

  Future<Department> getFullDetails(Department baseDept) async {
    // 1. Verificar caché
    if (state.containsKey(baseDept.id)) {
      return state[baseDept.id]!;
    }

    // 2. Si no existe, llamar API
    try {
      final extraData = await _apiService.getDepartmentDetails(baseDept.id);
      final capitalData = extraData['cityCapital'];

      final fullDept = Department(
        id: baseDept.id,
        idCaida: baseDept.idCaida,
        name: extraData['name'] ?? baseDept.name,
        assetPath: baseDept.assetPath,
        region: baseDept.region,
        description: extraData['description'],
        population: extraData['population'],
        surface: extraData['surface'],
        capitalName: capitalData != null ? capitalData['name'] : null,
        capitalDescription: capitalData != null
            ? capitalData['description']
            : null,
      );

      // 3. Actualizar estado
      state = {...state, baseDept.id: fullDept};
      return fullDept;
    } catch (e) {
      rethrow;
    }
  }
}
