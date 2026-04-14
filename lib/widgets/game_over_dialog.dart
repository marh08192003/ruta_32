import 'package:flutter/material.dart';
import 'package:ruta_32/l10n/app_localizations.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final bool isVictory;
  final VoidCallback onReset;
  final VoidCallback onMenu;
  final VoidCallback onExtraLife;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.isVictory,
    required this.onReset,
    required this.onMenu,
    required this.onExtraLife,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: Colors.blueGrey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        isVictory ? l10n.victory : l10n.gameOver,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isVictory ? Colors.greenAccent : Colors.redAccent,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVictory ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
            color: isVictory ? Colors.amber : Colors.orangeAccent,
            size: 80,
          ),
          const SizedBox(height: 20),
          Text(
            "${l10n.score}: $score",
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            if (!isVictory)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.movie, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: onExtraLife, // Quitamos el pop de aquí
                  label: const Text(
                    "VIDA EXTRA (AD)",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.replay, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[800],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onReset();
                },
                label: Text(
                  l10n.play.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.home, color: Colors.white),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white54),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onMenu();
                },
                label: Text(
                  l10n.mainMenu,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
