import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UbicacionPage extends StatefulWidget {
  const UbicacionPage({super.key});

  @override
  State<UbicacionPage> createState() => _UbicacionPageState();
}

class _UbicacionPageState extends State<UbicacionPage> {
  String ubicacion = "Obteniendo ubicación...";
  @override
  void initState() {
    super.initState();
    obtenerUbicacion();
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Mi ubicación"),
      centerTitle: true,
      elevation: 0,
    ),
    body: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Tu ubicación actual",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  ubicacion,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center ,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }

  Future<void> obtenerUbicacion() async {
    bool servicioActivo;
    LocationPermission permiso;
    //Verificar si el GPS está activado
    servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      setState(() => ubicacion = "Activa el GPS");
      return;
    }

    //verificar permisos de ubicación
    permiso = await Geolocator.checkPermission();

    //Si el permiso es denegado, solicitarlo
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        setState(() => ubicacion = "Permiso denegado");
        return;
      }
    }
    //Si el permiso es denegado permanentemente, mostrar mensaje
    if (permiso == LocationPermission.deniedForever) {
      setState(() => ubicacion = "Permiso denegado permanentemente");
      return;
    }
    
    Position posicion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      ubicacion =
          "Latitud: ${posicion.latitude}\nLongitud: ${posicion.longitude}";
    });
  }
}