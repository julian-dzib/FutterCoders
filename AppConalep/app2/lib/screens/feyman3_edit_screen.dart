import 'package:app2/widgets/button_widget.dart';
import 'package:app2/widgets/textField_widget.dart';
import 'package:flutter/material.dart';

class Feyman3EditScreen extends StatefulWidget {
  final String id;
  final String tituloInicial;
  final String temaInicial;
  //final Map<String, String> detalles;
  final void Function(String, String) onSave;

  const Feyman3EditScreen({
    super.key,
    required this.id,
    required this.tituloInicial,
    required this.temaInicial,
    //required this.detalles,
    required this.onSave,
  });

  @override
  State<Feyman3EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<Feyman3EditScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _temaController;

  @override
  void initState() {
    super.initState();
    //El formulario ya está prellenado con los valores actuales del título y tema.
    _tituloController = TextEditingController(text: widget.tituloInicial);
    _temaController = TextEditingController(text: widget.temaInicial);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _temaController.dispose();
    super.dispose();
  }

  void _guardar() {
    widget.onSave(_tituloController.text, _temaController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar")),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                TextfieldWidget(
                  //NO se guarda nada en la base de datos. Solo se actualizan los controladores.
                  controller: _tituloController, label: 'Titulo',
                  //decoration: const InputDecoration(labelText: "Título"),

                ),
                TextfieldWidget(
                  controller: _temaController, label: 'Tema',
                  //decoration: const InputDecoration(labelText: "Tema"),
                ),
                /*TextField(
                  controller: _tituloController,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _temaController,
                  decoration: const InputDecoration(labelText: "Tema"),
                ),
                */
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      onPressed: _guardar,
                      child: const Text("Guardar"),
                    ),
                  ],
                
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
