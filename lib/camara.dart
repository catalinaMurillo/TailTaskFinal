import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  File? _image;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tomar Foto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No hay foto tomada')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _takePicture,
              child: Text('Tomar Foto'),
            ),
            if (_image != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _image!.path); // Devuelve la ruta
                },
                child: Text('Usar esta foto'),
              ),
          ],
        ),
      ),
    );
  }
}

