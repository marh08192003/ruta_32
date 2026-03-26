import 'package:flutter/material.dart';
import 'package:ruta_32/l10n/app_localizations.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final bool isVictory;
  final VoidCallback onReset;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.isVictory,
    required this.onReset,
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
          const Icon(Icons.emoji_events, color: Colors.amber, size: 80),
          const SizedBox(height: 20),
          Text(
            "${l10n.score}: $score",
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[800],
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onReset();
            },
            child: Text(
              l10n.next, // Ahora que ejecutaste gen-l10n, esto ya no marcará error
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
