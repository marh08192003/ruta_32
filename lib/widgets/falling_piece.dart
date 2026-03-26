import 'package:flutter/material.dart';
import 'package:ruta_32/models/department_model.dart';

class FallingPieceWidget extends StatefulWidget {
  final Department department;
  final VoidCallback onPlaced;
  final VoidCallback onFailed;

  const FallingPieceWidget({super.key, 
    required this.department,
    required this.onPlaced,
    required this.onFailed,
  });

  @override
  State<FallingPieceWidget> createState() => _FallingPieceWidgetState();
}

class _FallingPieceWidgetState extends State<FallingPieceWidget> {
  Offset position = const Offset(0, 300); // Inicia un poco abajo

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          position += details.delta;
        });
      },
      onPanEnd: (details) {
        // LÓGICA DE VALIDACIÓN
        // Si la posición está muy cerca de (0,0), se considera acierto
        if (position.dx.abs() < 30 && position.dy.abs() < 30) {
          widget.onPlaced();
          setState(() => position = const Offset(0, 300)); // Reset para la siguiente
        } else {
          widget.onFailed();
          // Opcional: animar de regreso al inicio
        }
      },
      child: Transform.translate(
        offset: position,
        child: Image.asset(
          widget.department.assetPath,
          color: Colors.yellow.withOpacity(0.8), // Color temporal para destacar la pieza activa
          colorBlendMode: BlendMode.modulate,
        ),
      ),
    );
  }
}