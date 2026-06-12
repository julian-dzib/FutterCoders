import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
class Mapa extends StatefulWidget {
  const Mapa({super.key});
  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
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
      body: consulta
    ? const Center(child: CircularProgressIndicator())
    : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                positionCurrent!.latitude,
                positionCurrent!.longitude,
              ),
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("miUbicacion"),
                position: LatLng(
                  positionCurrent!.latitude,
                  positionCurrent!.longitude,
                ),
              ),
            },
          ),

          // 📍 PANEL SUPERIOR IZQUIERDO
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Tu ubicación actual",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      ubicacion,
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: obtenerUbicacion,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Actualizar"),
                        ),

                        ElevatedButton.icon(
                          onPressed: compartirUbicacion,
                          icon: const Icon(Icons.share),
                          label: const Text("Compartir"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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