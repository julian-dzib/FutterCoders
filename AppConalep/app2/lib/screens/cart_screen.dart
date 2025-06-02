import 'dart:io';
import 'package:app2/widget/cart_widgets.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPagePageState();
}

class _CartPagePageState extends State<CartPage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.7,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Coders"),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,

            children: [
              CardWidget (
                titulo: "Profesionnal Tecnico", 
                descripcion: 'Alumno del conalep, experto en programacion', 
                assetImagePath: 'assets/josue.jpg',
              ),
            CardWidget (
                titulo: "Profesionnal Tecnico", 
                descripcion: 'Mujer muy ruidosa', 
                assetImagePath: 'assets/cristal.jpg',
              ),
            CardWidget (
                titulo: "Profesionnal Tecnico", 
                descripcion: 'Persona adicta al chcocolate y a la sopa', 
                assetImagePath: 'assets/Adlemy.jpg',
              ),
              CardWidget (
                titulo: "Profesionnal Tecnico", 
                descripcion: 'Adicto al videojuego', 
                assetImagePath: 'assets/misa.jpg',
              ),
              CardWidget (
                titulo: "Ingniero", 
                descripcion: 'Mentor', 
                assetImagePath: 'assets/1.jpg',
              ),
            
            ]
          ),
        ),
      ),
      
    );
  }
}
