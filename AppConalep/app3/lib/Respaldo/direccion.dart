import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
class Direccion extends StatefulWidget {
  const Direccion({super.key});
  @override
  State<Direccion> createState() => _DireccionState();
}

class _DireccionState extends State<Direccion> {
  String ubicacion = 'Consultando la ubicacion';
  //Variable para controlar el estado de la consulta
  bool consulta=true;
  //Referencia 
  Position? positionCurrent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Agregar el codigo anterior que se tenia
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

              //Agregar 1 el progress bar y cuando se este consultando la ubicacion mostrar el progress bar 
              //y cuando se tenga la ubicacion mostrar la direccion (column)
              child: consulta ? const CircularProgressIndicator() 
              :Column(
                //
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

                  //Agregar 2 el boton actualizar ubicacion
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: obtenerUbicacion,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Actualizar"),
                    ),

                  const SizedBox(height: 10),

                  //Agregar 3 el Botón compartir
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


  //Verificar si esta activado el GPS
  Future<void> obtenerUbicacion() async {
    setState(() =>
      consulta = true
    );

    bool serviccioActivo;
    LocationPermission permiso;
    //flujo 1
    //Verificar si la ubicacion esta activa
    serviccioActivo = await Geolocator.isLocationServiceEnabled();
    if(!serviccioActivo){
      setState((){
        ubicacion = 'El gps esta desactivado, por favor active el gps';
        consulta = false;
      }
      );
      return;
    }
    //flujo 2 y 3
    permiso = await Geolocator.checkPermission();

    if(permiso == LocationPermission.denied){
        permiso = await Geolocator.requestPermission();
        if(permiso == LocationPermission.denied){
          setState((){
            ubicacion = 'Los permisos de ubicacion han sido denegados, por favor acepte los permisos';
            consulta=false;

          }
          );
        }
    }
    if(permiso == LocationPermission.deniedForever){
        setState((){
          ubicacion = 'Los permisos de la ubicacion han sido bloqueados';
          consulta=false;

        }
        );
    }
    //flujo 4
    //A partir del gps obtener la ubicacion
    Position ubicacionActual = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    positionCurrent = ubicacionActual;

    List <Placemark> result = await  placemarkFromCoordinates(
      ubicacionActual.latitude, 
      ubicacionActual.longitude,
    );

    //Asignar la direccion 
    Placemark direcion = result.first;

    setState((){
      ubicacion = 'Calle${direcion.street}, Localidad${direcion.locality}';
      consulta=false;
    }
    );

  }

    //Agregar 4 - Difinir un nuevo metodo para compartir la ubicacion
  void compartirUbicacion() {
    if (positionCurrent == null) return;

    final url ="https://www.google.com/maps?q=${positionCurrent!.latitude},${positionCurrent!.longitude}";
    SharePlus.instance.share(
        ShareParams(
          text: "Mi ubicación es:\n$ubicacion",
          uri: Uri.parse(url)
        )
    );

    //Antigua forma
    //Share.share("Mi ubicación actual:\n$ubicacion\n$url");
  }

  


}