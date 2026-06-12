import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoPage extends StatefulWidget {
  final String title; 
  const FotoPage({super.key, required this.title});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {

  File? _imagen;
  final picker = ImagePicker();
  final TextEditingController textoController = TextEditingController();
  String enviar = "";
  
  // Tomar foto
  Future tomarFoto() async {
    final foto = await picker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      setState(() {
        _imagen = File(foto.path);
      });
    }
  }

  // Subir imagen
  Future subirImagen() async {
    final imagen = await picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      setState(() {
        _imagen = File(imagen.path);
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            // AREA DE IMAGEN
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: _imagen == null
                  ? Center(child: Text("No hay imagen"))
                  : Image.file(_imagen!, fit: BoxFit.cover),
            ),

            SizedBox(height: 20),

            // CAMPO DE TEXTO
            TextField(
              controller: textoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Escribe un mensaje",
              ),
            ),

            SizedBox(height: 20),

            // BOTON ENVIAR
            ElevatedButton(
              onPressed: () {  },
              child: Text("Enviar"),
            )
          ],
        ),
      ),

      // FLOATING BUTTONS
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          FloatingActionButton(
            heroTag: "camara",
            onPressed: tomarFoto,
            child: Icon(Icons.camera_alt),
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "galeria",
            onPressed: subirImagen,
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}