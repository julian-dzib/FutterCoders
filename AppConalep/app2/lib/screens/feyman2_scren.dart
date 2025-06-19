import 'package:app2/models/feyman_model.dart';
import 'package:app2/services/feyma_service.dart';
import 'package:flutter/material.dart';

class Feyman2Screen extends StatefulWidget {
  const Feyman2Screen({super.key});

  @override
  State<Feyman2Screen> createState() => _Feyman2ScreenState();
}

class _Feyman2ScreenState extends State<Feyman2Screen> {
  final Feyman2Screen _controller = Feyman2Screen();
  List<FeymanModel> feymans = [];

  @override
  void initState() {
    super.initState();
    fetchFeymans();
  }

  Future<void> fetchFeymans() async {
    //feymans = await _controller.getFichas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registros Feyman')),
      body: feymans.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: feymans.length,
              itemBuilder: (context, index) {
                final f = feymans[index];
                return ListTile(
                  title: Text(f.titulo),
                  subtitle: Text('Tema: ${f.tema}'),
                  trailing: Text('ID: ${f.id.substring(0, 5)}...'),
                  onTap: () {
                    // Mostrar detalle si quieres
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(f.titulo),
                        content: Text('Explicación: ${f.explicacion}\n\nDudas: ${f.dudas}\n\nEjemplos: ${f.ejemplos}'),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
