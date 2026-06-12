import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:share_plus/share_plus.dart';

class UbicacionMejoradaPage extends StatefulWidget {
  const UbicacionMejoradaPage({super.key});

  @override
  State<UbicacionMejoradaPage> createState() => _UbicacionMejoradaPageState();
}

class _UbicacionMejoradaPageState extends State<UbicacionMejoradaPage> {
  //Agregar - Mantenerlo tal cual
  String ubicacion = "Obteniendo ubicación...";
  //Agregar - Lo nuevo
  bool actualizando = true;
  Position? posicionActual;

  @override
  void initState() {
    super.initState();
    obtenerUbicacion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Ubicación"),
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
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: actualizando
                  ? const CircularProgressIndicator()
                  : Column(
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
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        // Botón actualizar
                        ElevatedButton.icon(
                          onPressed: obtenerUbicacion,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Actualizar"),
                        ),

                        const SizedBox(height: 10),

                        // Botón compartir
                        ElevatedButton.icon(
                          onPressed: compartirUbicacion,
                          icon: const Icon(Icons.share),
                          label: const Text("Compartir ubicación"),
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
    //Agregar
    setState(() => actualizando = true);

    bool servicioActivo;
    LocationPermission permiso;
    //...............................................................
    //Verificar si el GPS está activado
    servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      //Agregar 2 - Eliminar el =
      setState(() {
        //Agregar 3 - Cambiar el estatus
        ubicacion = "Activa la Ubicacion";
        actualizando=false;
      });

      return;
    
    }
    
    //...............................................................
    //verificar permisos de ubicación
    permiso = await Geolocator.checkPermission();

  
    //...............................................................
    //Si el permiso es denegado, solicitarlo
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        //Agregar 4 -  Cambiar el estatus
        setState((){
          ubicacion = "Permiso denegado";
          //Agregar 5 - Cambiar el estutus
          actualizando= false;
        });
        return;
      }
    }
    
    //...............................................................
    //Si el permiso es denegado permanentemente, mostrar mensaje
    if (permiso == LocationPermission.deniedForever) {
      setState(() {
        ubicacion = "Permiso denegado permanentemente";
        actualizando = false;
      } );
      return;
    }
    
    //...............................................................
    //Obtener las coordenadas
    Position posicion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //Agregar 6 - Asignar el valor obtenido (Latitud y Longitud)
    posicionActual = posicion;

    //Agregar 7 - Convertir la posiciones en coordenadas
    List <Placemark> result = await placemarkFromCoordinates(
      posicion.latitude, posicion.longitude,
    );
    //Agregar 8 - Ya ahora asignamos nuestra direccion
    Placemark direccion = result.first;


    setState(() {
      ubicacion =
          //Agregar 9 - Fijarse que ya podemos utilizar los parametros como localidad y ciudad
          "${direccion.street}, ${direccion.locality}, ${direccion.administrativeArea}, ${direccion.country}";
          actualizando = false;
    });
  }

  //Agregar 10 - Difinir un nuevo metodo para compartir la ubicacion
  void compartirUbicacion() {
    if (posicionActual == null) return;

    final url ="https://www.google.com/maps?q=${posicionActual!.latitude},${posicionActual!.longitude}";
    SharePlus.instance.share(
        ShareParams(
          text: "Mi ubicación actual:\n$ubicacion\n$url",
        )
    );

    //Antigua forma
    //Share.share("Mi ubicación actual:\n$ubicacion\n$url");
  }





}