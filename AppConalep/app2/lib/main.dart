import 'package:app2/screens/camara_screen.dart';
import 'package:app2/screens/feyman2_scren.dart';
import 'package:app2/screens/feyman_screen.dart';
import 'package:app2/screens/menuLateral_screen.dart';
import 'package:app2/screens/reconcimiento_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coders',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MenuLateralScreen(),
        '/camera': (context) => CamaraScreen(),
        '/reco': (context) => ReconcimientoScreen(),
        '/ejem': (context) => FeymanScreen(),
        '/ejem2': (context) => Feyman2Screen(),
        //'/settings': (context) => CamaraScreen(),
      },
    );
  }
}

