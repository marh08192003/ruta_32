import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruta_32/state/department_provider.dart';
import '../../models/department_model.dart';
import '../../services/api_service.dart';

class DepartmentDetailScreen extends ConsumerStatefulWidget {
  final Department department;

  const DepartmentDetailScreen({super.key, required this.department});

  @override
  ConsumerState<DepartmentDetailScreen> createState() =>
      _DepartmentDetailScreenState();
}

class _DepartmentDetailScreenState
    extends ConsumerState<DepartmentDetailScreen> {
  final ApiService apiService = ApiService();
  late Department currentDept;
  bool isLoadingStats = true;
  late ScrollController _heritageScrollController;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _heritageScrollController = ScrollController();
    currentDept = widget.department;
    _loadFullDetails();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _heritageScrollController.dispose();
    super.dispose();
  }

  // Método para cargar los datos faltantes (población y superficie)
  Future<void> _loadFullDetails() async {
    try {
      // Leemos el provider y llamamos a getFullDetails (que ya maneja el caché internamente)
      final fullDept = await ref
          .read(departmentCacheProvider.notifier)
          .getFullDetails(widget.department);

      if (mounted) {
        setState(() {
          currentDept = fullDept;
          isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingStats = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentDept.name), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            _buildQuickStats(),

            _buildDescriptionSection(),

            _buildSectionTitle("Patrimonio Inmaterial"),
            _buildHeritageInfo(),

            _buildSectionTitle("Gastronomía Típica"),
            _buildTypicalDishes(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Hero(
        tag: 'dept_${currentDept.id}',
        child: Image.asset(
          currentDept.detailImage,
          fit: BoxFit
              .cover, // <--- CAMBIA ESTO: Recorta la imagen para llenar el 100% del espacio
          width: double.infinity,
          height: 250,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTypicalDishes() {
    return FutureBuilder(
      future: apiService.getTypicalDishes(currentDept.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final dishes = snapshot.data ?? [];
        if (dishes.isEmpty) return const SizedBox.shrink();

        // Si hay 2 o menos, usamos 1 fila para que salgan al lado.
        // Si hay más de 2, usamos 2 filas para tu diseño de "cuadrícula horizontal".
        int rows = dishes.length <= 2 ? 1 : 2;
        double containerHeight = dishes.length <= 2 ? 180 : 340;

        return SizedBox(
          height: containerHeight,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rows, // Dinámico según cantidad
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: rows == 1 ? 0.7 : 1.1, // Ajustamos proporción
            ),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        dish['imageUrl'] ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dish['name'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeritageInfo() {
    return FutureBuilder(
      future: apiService.getHeritage(currentDept.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final heritages = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Habilitamos el scroll horizontal
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            // Usamos Row para colocar uno al lado del otro
            children: heritages.map((item) {
              return Container(
                // Definimos un ancho fijo para que se vea como tarjeta de carrusel
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 12,
                ), // Espacio a la derecha
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: const Border(
                    left: BorderSide(width: 4, color: Colors.orange),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Ajusta al contenido
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines:
                                2, // Limitamos para mantener consistencia visual
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['scope'] ?? 'Patrimonio Cultural',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors
                            .orange
                            .shade800, // Ajusté el color para legibilidad
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem(
            icon: Icons.people_outline,
            label: "Población",
            value: currentDept.population != null
                ? "${(currentDept.population! / 1000000).toStringAsFixed(1)}M"
                : "-",
          ),
          _statItem(
            icon: Icons.square_foot_outlined,
            label: "Superficie",
            value: currentDept.surface != null
                ? "${currentDept.surface} km²"
                : "-",
          ),
          _statItem(
            icon: Icons.map_outlined,
            label: "Región",
            value: "API #${currentDept.id}",
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descripción del Departamento
          Text(
            "Sobre el departamento",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            currentDept.description ?? "Cargando descripción...",
            style: const TextStyle(height: 1.5),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 20),

          // Info de la Capital
          if (currentDept.capitalName != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(width: 4, color: Colors.blue),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_city, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        "Capital: ${currentDept.capitalName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentDept.capitalDescription ?? "",
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
