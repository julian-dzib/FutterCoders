import 'dart:io';

import 'package:app2/components/galeria_components.dart';
import 'package:flutter/material.dart';

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({super.key});

  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  String? photoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: photoPath != null
            ? Image.file(
                File(photoPath!),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              )
            : const Text("Selecciona o toma una foto"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.image),
            onPressed: () async {
              final path = await CameraGalleryService().selectPhoto();
              if (path == null) return;
              setState(() {
                photoPath = path;
              });
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () async {
              final path = await CameraGalleryService().takePhoto();
              if (path == null) return;
              setState(() {
                photoPath = path;
              });
            },
          ),
        ],
      ),
    );
  }
}
