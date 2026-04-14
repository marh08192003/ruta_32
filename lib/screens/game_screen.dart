import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruta_32/l10n/app_localizations.dart';
import 'package:ruta_32/models/department_model.dart';
import 'package:ruta_32/widgets/falling_piece.dart';
import 'package:ruta_32/widgets/game_over_dialog.dart';
import '../state/game_state.dart';
import '../data/departments_data.dart';
import '../widgets/rewarded_ad_manager.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  // Mantenemos la instancia aquí para que no se resetee
  late RewardedAdManager rewardedManager;

  @override
  void initState() {
    super.initState();
    rewardedManager = RewardedAdManager();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    // ESCUCHA PARA PRECARGA: Cuando queda 1 vida, cargamos el anuncio
    ref.listen(gameProvider.select((s) => s.lives), (prev, next) {
      if (next == 1) {
        debugPrint("Precargando anuncio: Solo queda 1 vida");
        rewardedManager.loadAd();
      }
    });

    // Escuchar para el GameOver
    ref.listen(gameProvider, (previous, next) {
      if (next.isGameOver && (previous == null || !previous.isGameOver)) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => GameOverDialog(
            score: next.score,
            isVictory: next.placedIds.length == allDepartments.length,
            onReset: () => ref.read(gameProvider.notifier).resetGame(),
            onMenu: () {
              ref.read(gameProvider.notifier).resetGame();
              Navigator.of(dialogContext).pop();
            },
            onExtraLife: () {
              if (rewardedManager.isAdLoaded) {
                rewardedManager.showAd(
                  onRewardEarned: () {
                    Navigator.of(dialogContext).pop();
                    ref.read(gameProvider.notifier).addExtraLife();
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("El anuncio no está listo aún..."),
                  ),
                );
                rewardedManager.loadAd();
              }
            },
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, gameState),
            if (!gameState.isGameOver)
              _buildTargetInfo(context, gameState.currentDept),

            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1837 / 2477,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Fondo
                      Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'assets/images/departments/colombia_guia.png',
                        ),
                      ),

                      // Departamentos ya colocados (se dibujan en su posición original 0,0)
                      ...gameState.placedIds.map((id) {
                        final dept = allDepartments.firstWhere(
                          (d) => d.idCaida == id,
                        );
                        return Image.asset(dept.assetPath);
                      }),

                      // Pieza activa con la nueva lógica de FallingPieceWidget
                      if (!gameState.isGameOver)
                        FallingPieceWidget(
                          // Al usar UniqueKey, obligamos a Flutter a reiniciar el estado del widget
                          // cada vez que el departamento cambie, reseteando el Timer y la posición.
                          key: UniqueKey(),
                          department: gameState.currentDept,
                          onPlaced: () => gameNotifier.onRightPlacement(),
                          onFailed: () => gameNotifier.onWrongPlacement(),
                        )
                      else
                        Center(
                          child: Text(
                            l10n.gameOver,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
  }

  // Header ajustado con traducciones
  Widget _buildHeader(BuildContext context, GameState state) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Usamos el texto de "Vidas" del ARB
          Text(
            "${l10n.lives}: ${'❤️' * state.lives}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          // Usamos el texto de "Puntaje" del ARB
          Text(
            "${l10n.score}: ${state.score}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetInfo(BuildContext context, Department currentDept) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.yellow.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            l10n.departmentPlacement(currentDept.name), // Usa el placeholder
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Aquí podrías añadir la superficie si la incluyes en tu modelo
          // Text(l10n.surface("109.665"), style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
