import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      //ENVOLVER EL WIDGEDT CON UN CONTENEDOR
      body: Container(
        //AGREGAR EL WIDGET TEXT 
        //color: Colors.blue,
        
        //AGREGAR UN PADDING /AUMENTAR EL ESPACIADO INTERNO DEL ELEMENTO
        /////padding: EdgeInsets.all(20.0),
        padding: EdgeInsets.only(left: 20.0,top: 20.0, right: 20.0, bottom: 20.0),
        /////padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        
        //AGREGAR UN MARGIN /SEPARAR UN ELEMENTO DE UN WIDGET / HAY MARGIN TOP
        margin: EdgeInsets.all(20.0),

        //AGREGAR LA PROPIEDA DECORATION 
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle, 
        ),
        //ALINEAR EL CONTENEDOR
        width: 100,
        height: 100,
        alignment: Alignment.center,
        
        //AGREGAR EL WIDGET TEXT 
        child: Text("Texto"),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
