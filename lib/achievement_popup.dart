import 'package:flutter/material.dart';

class AchievementPopup extends StatelessWidget {
  final String title;
  final String description;

  AchievementPopup({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, size: 50, color: Colors.amber),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void showAchievement(BuildContext context, String title, String description) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          // Fondo semitransparente
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Widget del logro
          AchievementPopup(
            title: title,
            description: description,
          ),
        ],
      );
    },
  );

  // Añadir el overlay
  overlay.insert(overlayEntry);

  // Quitar el overlay después de 3 segundos
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}