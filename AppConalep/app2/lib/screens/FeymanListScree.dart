import 'package:app2/screens/feyman3_edit_screen.dart';
import 'package:app2/widgets/buttonIcon.dart';
import 'package:app2/widgets/cardAnimation_widget.dart';
import 'package:app2/widgets/cardDetalles_wdiget.dart';
import 'package:app2/widgets/finalDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:app2/models/feyman_model.dart';
import 'package:app2/services/feyma_service.dart';

class FeymanListScreen extends StatefulWidget {
  const FeymanListScreen({super.key});

  @override
  State<FeymanListScreen> createState() => _FeymanListScreenState();
}

class _FeymanListScreenState extends State<FeymanListScreen> {
  // Servicio genérico para leer datos de la colección "feyman"
  final service = FirestoreService<FeymanModel>(
    collection: 'feyman',
    fromMap: (id, data) => FeymanModel.fromMap(id, data),
  );

  // Futuro que obtendrá la lista de registros
  late Future<List<FeymanModel>> futureFeymans;

  
  void _reload() {
    setState(() {
      futureFeymans = service.get();
    });
  }

  @override
  void initState() {
    super.initState();
    _reload();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feyman"),),
      body: FutureBuilder<List<FeymanModel>>(
        future: futureFeymans,
        builder: (context, estado) {
          print(estado.data);

          // Si los datos están cargando
        if (estado.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!estado.hasData || estado.data!.isEmpty) {
          return const Center(child: Text("No hay registros aún."));
        }

        if (estado.hasError) {
          return Text('Error: ${estado.error}');
        }




          // Si sí hay datos, los guardamos en una lista
          final items = estado.data!;

          // Usamos ListView para mostrar cada modelo en una tarjeta
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final model = items[index];

              return Center(
                child: CardanimationWidget( id: model.id,
                title: model.titulo,
                subtitle: model.tema,
                details: {
                  "Hora": model.hora.format(context),
                  "Fecha": model.fecha.toLocal().toString().split(" ")[0],
                },
                onDelete: () async {
                  await service.delete(model.id);
                  _reload();
                },
                onUpdate: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Feyman3EditScreen(
                      //Cuando navegas a Feyman3EditScreen, pasas:
                      id: model.id,
                      tituloInicial: model.titulo,
                      temaInicial: model.tema,
                      //detalles: {
                        //"Hora": model.hora.format(context),
                        //"Fecha": model.fecha.toLocal().toString().split(" ")[0],
                      //},
                      
                      onSave: (newTitle, newTema) async {
                        await service.update(model.id, {
                          "titulo": newTitle,
                          "tema": newTema,
                        });
                        _reload();
                      },
                    ),
                  ));
                },
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Finaldetailcard(
                        titulo: model.titulo,
                        tema: model.tema, 
                        explicacion: model.dudas,
                        dudas: model.dudas,
                        ejemplos: model.ejemplos,
                        fecha: model.fecha.toLocal().toString().split(" ")[0],
                        hora: model.hora.format(context),
                    ),
                  ));
                },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/ejem'),
        child: const Icon(Icons.add),
      ),
    );
  }
}