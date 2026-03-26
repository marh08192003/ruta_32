import 'package:flutter/material.dart';
import 'package:ruta_32/models/department_model.dart';

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

class _FallingPieceWidgetState extends State<FallingPieceWidget>
    with SingleTickerProviderStateMixin {
  // Posición actual de la pieza
  Offset _currentPosition = const Offset(0, 400);

  // Controlador para el "rebote" cuando el usuario falla
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Animación inicial: La pieza aparece subiendo
    _animateTo(const Offset(0, 200));
  }

  @override
  void didUpdateWidget(FallingPieceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el departamento cambió (acierto), reseteamos posición
    if (oldWidget.department.idCaida != widget.department.idCaida) {
      _animateTo(const Offset(0, 200));
    }
  }

  void _animateTo(Offset target) {
    _animation = Tween<Offset>(
      begin: _currentPosition,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.reset();
    _controller.forward();

    _animation.addListener(() {
      setState(() {
        _currentPosition = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          // Mientras el usuario arrastra, actualizamos la posición manualmente
          _currentPosition += details.delta;
        });
      },
      onPanEnd: (details) {
        // VALIDACIÓN: Margen de error de 40 píxeles (ajustable)
        if (_currentPosition.dx.abs() < 40 && _currentPosition.dy.abs() < 40) {
          widget.onPlaced();
        } else {
          widget.onFailed();
          // EFECTO REBOTE: Si falla, la pieza vuelve al punto de espera
          _animateTo(const Offset(0, 200));
        }
      },
      child: Transform.translate(
        offset: _currentPosition,
        child: Image.asset(
          widget.department.assetPath,
          // Color amarillento para resaltar la pieza que el usuario debe mover
          color: Colors.yellow.withOpacity(0.7),
          colorBlendMode: BlendMode.modulate,
        ),
      ),
    );
  }
}
