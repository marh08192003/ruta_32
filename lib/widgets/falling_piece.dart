import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/department_model.dart';

// --- ESTA ES LA PARTE QUE FALTABA ---
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
  final Random _random = Random();

  late double _offsetX;
  double _offsetY = -250.0;
  Timer? _timer;
  bool _isFinalized = false;

  @override
  void initState() {
    super.initState();
    // Inicializamos la X aleatoria
    _offsetX = (widget.department.idCaida == 32)
        ? 100.0
        : (_random.nextDouble() * 2 - 1) * 140.0;
    _startFalling();
  }

  void _startFalling() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) return;

      setState(() {
        _offsetY += 1.5;
      });

      if (_offsetY >= 0) {
        _timer?.cancel();
        _checkResult();
      }
    });
  }

  void _checkResult() {
    if (_isFinalized) return;
    _isFinalized = true;

    if (_offsetX.abs() < 50) {
      widget.onPlaced();
    } else {
      widget.onFailed();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (_isFinalized) return;
          setState(() {
            _offsetX += details.delta.dx;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Transform.translate(
            offset: Offset(_offsetX, _offsetY),
            child: Image.asset(
              widget.department.assetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
