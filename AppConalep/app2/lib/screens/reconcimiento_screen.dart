import 'dart:io';

import 'package:app2/services/ObjectDetectionService.dart';
import 'package:app2/components/galeria_components.dart';
import 'package:flutter/material.dart';

class ReconcimientoScreen extends StatefulWidget {
  const ReconcimientoScreen({super.key});

  @override
  State<ReconcimientoScreen> createState() => _ReconocimientoScreenState();
}

class _ReconocimientoScreenState extends State<ReconcimientoScreen> {
  String? photoPath;
  List<Map<String, dynamic>> detections = [];
  bool isLoading = false;

  Future<void> _analyzeImage() async {
    if (photoPath == null) return;

    setState(() {
      isLoading = true;
      detections = [];
    });

    try {
      final result = await ObjectDetectionService().detectObjects(photoPath!);
      setState(() {
        detections = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            if (photoPath != null)
              SizedBox(
                height: 350,
                child: Image.file(
                  File(photoPath!),
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (detections.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: detections.map((det) {
                  final label = det['label'];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.label),
                      title: Text(label),
                    ),
                  );
                }).toList(),
              )

            else if (photoPath != null)
              const Text("Presiona el botón de análisis para detectar objetos"),
          ],
        ),
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
          const SizedBox(height: 2),
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
          //const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _analyzeImage,
            child: const Icon(Icons.analytics),
          ),
        ],
      ),
    );
  }
}
