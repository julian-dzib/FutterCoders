import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String assetImagePath;

  const CardWidget({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //Agregar un borde redondeado, sombra
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //Establecer un margin a todos los lados - espacio entre cada widget 
      margin: EdgeInsets.all(20),
      //Establecer una sobra elevada al card 
      elevation: 8,
      //Utilizarcolumnas para organizar los elementos de arriba hacia abajo.
      child: Column(
        //Hacer que la columna ocupe solo el espacio necesario
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //widget para mostrar filas de texto e íconos.
          ListTile(
            title: Text(
              titulo,
              textAlign: TextAlign.center
            ),
            
          ),
          Image.asset(
            assetImagePath,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              descripcion,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),

            ),
          ),
        ],
      ),
    );
  }
}
