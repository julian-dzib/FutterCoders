import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  //Definir mis variables
  final String text;
  //funcion que no recibe valores y parametros
  final VoidCallback onPressed;

  const ButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //Inclir la funcionalidad del boton 
      onPressed: onPressed,
      //Agregar un stilo a nuestro button
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        //Establecer un tamanio minimo para el botton
        minimumSize: const Size(double.infinity, 50),
        //Agrear un border rectangular
        //Esquinas Redondeados
        //De un radio de 25 pixeles
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      //Incluir un texto 
      child: Text(
        text,
        //Agregarle estilo a el texto
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
