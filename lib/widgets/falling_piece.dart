import 'dart:async';
import 'package:flutter/material.dart';
import '../models/department_model.dart';

class FallingPieceWidget extends StatefulWidget {
  final Department department;
  final VoidCallback onPlaced;
  final VoidCallback onFailed;

  const FallingPieceWidget({
    super.key,
    required this.department,
    required this.onPlaced,
    required this.onFailed,
  });

  @override
  State<FallingPieceWidget> createState() => _FallingPieceWidgetState();
}

class _FallingPieceWidgetState extends State<FallingPieceWidget> {
  // Solo controlamos X (horizontal) y Y (caída)
  double _offsetX = 0.0;
  double _offsetY = -200.0; // Inicia arriba, fuera de pantalla
  Timer? _timer;
  bool _isPlaced = false;

  @override
  void initState() {
    super.initState();
    _startFalling();
  }

  void _startFalling() {
    // Velocidad de caída: aumenta Y cada 16ms (~60fps)
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _offsetY +=
            2.5; // Ajusta este número para cambiar la dificultad (velocidad)
      });

      // Si la pieza llega a la base (Y = 0 es su posición real en el Stack)
      if (_offsetY >= 0) {
        _checkResult();
      }
    });
  }

  void _checkResult() {
    _timer?.cancel();
    if (_isPlaced) return;
    _isPlaced = true;

    // VALIDACIÓN: Si al llegar a Y=0, la X está cerca de 0 (centro)
    // Margen de error de 50 píxeles
    if (_offsetX.abs() < 50) {
      widget.onPlaced();
    } else {
      widget.onFailed();
    }

    // Reset para la siguiente pieza
    setState(() {
      _offsetY = -200.0;
      _offsetX = 0.0;
      _isPlaced = false;
    });
    _startFalling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Movimiento horizontal únicamente
      onPanUpdate: (details) {
        setState(() {
          _offsetX += details.delta.dx;
        });
      },
      child: Transform.translate(
        offset: Offset(_offsetX, _offsetY),
        child: Image.asset(
          widget.department.assetPath,
          // Sin fondo amarillo, solo la imagen pura
        ),
      ),
    );
  }
}
