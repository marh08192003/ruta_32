import 'dart:async';
import 'dart:math';
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
  final Random _random = Random();
  static const double _spawnXRange =
      140.0; // +/- en X al aparecer (más corridos)

  double _offsetX = 0.0;
  double _offsetY = -260.0; // Inicia más arriba, afuera de pantalla
  Timer? _timer;
  bool _isPlaced = false;

  @override
  void initState() {
    super.initState();
    _resetPosition();
    _startFalling();
  }

  double _randomX() {
    if (widget.department.idCaida == 32) {
      return 100.0;
    }
    return (_random.nextDouble() * 2 - 1) * _spawnXRange;
  }

  void _resetPosition() {
    _offsetX = _randomX();
    _offsetY = -200.0;
    _isPlaced = false;
  }

  void _startFalling() {
    // Velocidad de caída: aumenta Y cada 16ms (~60fps)
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _offsetY += 1.3; // Más lento: velocidad reducida para caída más suave
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
      _resetPosition();
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
