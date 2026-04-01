import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ruta_32/l10n/app_localizations.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1320),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.tutorialTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEN DE REFERENCIA (Aquí puedes poner una captura de tu juego)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 1837 / 2477,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellowAccent.withOpacity(0.5),
                    ),
                    color: const Color(0xFF0B1320),
                  ),
                  child: Image.asset(
                    'assets/images/info/info.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // SECCIÓN: CÓMO JUGAR
            _buildSectionTitle(Icons.sports_esports, l10n.gameMode),
            const SizedBox(height: 16),
            _buildInstructionStep("1", l10n.howToPlayText.split('\n')[0]),
            _buildInstructionStep("2", l10n.howToPlayText.split('\n')[1]),
            _buildInstructionStep("3", l10n.howToPlayText.split('\n')[2]),
            _buildInstructionStep("4", l10n.howToPlayText.split('\n')[3]),

            const SizedBox(height: 32),

            // SECCIÓN: SOBRE COLOMBIA
            _buildSectionTitle(Icons.map, "Colombia"),
            const SizedBox(height: 12),
            Text(
              l10n.aboutColombia,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // BOTÓN DE CIERRE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.ok,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellowAccent, size: 24),
        const SizedBox(width: 12),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white10,
            child: Text(
              number,
              style: const TextStyle(color: Colors.yellowAccent, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text.replaceAll(
                RegExp(r'^\d+\.\s*'),
                '',
              ), // Quita el número del string original
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
