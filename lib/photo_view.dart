import 'package:flutter/material.dart';

class PhotoViewScreen extends StatelessWidget {
  final String photoPath;

  PhotoViewScreen({required this.photoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foto de la Tarea')),
      body: Center(
        child: Image.asset(photoPath), // Aquí deberías mostrar la foto real
      ),
    );
  }
}