import 'package:flutter/material.dart';
import 'package:ruta_32/l10n/app_localizations.dart';
import 'package:ruta_32/screens/department/department_list_screen.dart';

class RegionsScreen extends StatelessWidget {
  const RegionsScreen({super.key});

  final List<String> regions = const [
    "Amazonía",
    "Andina",
    "Caribe",
    "Pacífica",
    "Orinoquía",
    "Insular",
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.regionsOfColombia)),
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
