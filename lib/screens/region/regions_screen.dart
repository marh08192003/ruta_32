import 'package:flutter/material.dart';
import 'package:ruta_32/screens/department/department_list_screen.dart';

class RegionsScreen extends StatelessWidget {
  final List<String> regions = [
    "Amazonía",
    "Andina",
    "Caribe",
    "Pacífica",
    "Orinoquía",
    "Insular",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Regiones de Colombia")),
      body: ListView.builder(
        itemCount: regions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(regions[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DepartmentListScreen(region: regions[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
