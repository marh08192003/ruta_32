import 'package:flutter/material.dart';
import 'package:ruta_32/data/departments_data.dart';
import 'package:ruta_32/l10n/app_localizations.dart';
import 'package:ruta_32/screens/department/department_detail_screen.dart';

class DepartmentListScreen extends StatelessWidget {
  final String region;
  const DepartmentListScreen({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Filtramos la lista global que ya tienes
    final filteredDepts = allDepartments
        .where((d) => d.region == region)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.departmentsByRegion(region))),
      body: ListView.builder(
        itemCount: filteredDepts.length,
        itemBuilder: (context, index) {
          final dept = filteredDepts[index];
          return ListTile(
            leading: Image.asset(
              dept.selectionImage,
              width: 40,
            ), // Imagen de selección
            title: Text(dept.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DepartmentDetailScreen(department: dept),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
