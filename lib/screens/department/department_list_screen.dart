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
      appBar: AppBar(
        title: Text(
          l10n.departmentsByRegion(region),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: filteredDepts.length,
        itemBuilder: (context, index) {
          final dept = filteredDepts[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen de fondo con Hero para transición fluida hacia el detalle
                  Hero(
                    tag: 'dept_${dept.id}',
                    child: Image.asset(dept.detailImage, fit: BoxFit.cover),
                  ),
                  // Gradiente superpuesto para garantizar la legibilidad del texto siempre
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Área para toques y onda de efecto
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DepartmentDetailScreen(department: dept),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    dept.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
