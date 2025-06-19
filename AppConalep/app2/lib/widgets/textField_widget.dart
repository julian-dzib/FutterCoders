import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  //Entrada de texto
  final String label;
  //Definir una variable para controlar lo que se ingresa
  final TextEditingController controller;
  //Establecer un limete para nuestra entrada de datos
  final int maxLines;

  const TextfieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      //Establecer la alineación de los elementos horizontales dentro de un widget en Flutter.
      //Alinea el label y el textfield
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Defini el texto con su estilo
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        //Dentro de mi sizebox genero mi textfield
        const SizedBox(height: 5),
        TextField(
          //Paso como parametro mi controlador para que pueda controlar lo que ingrese
          controller: controller,
          //Establezco mi maximo de lineas
          maxLines: maxLines,
          //Agrego una decoracion a mi textforfield
          decoration: InputDecoration(
            //Text invisinle
            hintText: 'Escribe aquí...',
            //rellenar el fondo de mi textfield
            filled: false,
            //Establecer el color de fondo
            fillColor: Colors.white,
            //Agregar un border redondeado 
            //borde visible con esquinas redondeadas
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        //Agregar una separacion entre otros widgets
        const SizedBox(height: 15),
      ],
    );
  }
}
