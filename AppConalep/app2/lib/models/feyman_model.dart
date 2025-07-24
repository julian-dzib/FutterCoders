import 'package:flutter/material.dart';

class FeymanModel {
  String id;
  String titulo;
  String tema;
  String explicacion;
  String dudas;
  String ejemplos;
  TimeOfDay hora;
  DateTime fecha;

  FeymanModel({
    required this.id,
    required this.titulo,
    required this.tema,
    required this.explicacion,
    required this.dudas,
    required this.ejemplos,

    required this.fecha,
    required this.hora
  });

  //Convierte tu objeto Dart (modelo) en un mapa tipo JSON (Map<String, dynamic>).
  //Cuando guardas en Firestore/API
  //Recibe un modelo y lo transforma en un map (json)
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'tema': tema,
      'explicacion': explicacion,
      'dudas': dudas,
      'ejemplos': ejemplos,
      //TRATAR MIS DATOS
      'hora': '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
      'fecha': fecha.toIso8601String(), // Formato estándar para fechas
    };
  }
  //Hace lo inverso: convierte un mapa JSON (Map<String, dynamic>) en un objeto Dart (modelo).
  //Cuando lees de Firestore/API
  //Recibe un mapa y lo transforma en un modelo

  factory FeymanModel.fromMap(String id, Map<String, dynamic> data) {

    final tiempo= (data['hora'] as String).split(':');
    final hora= int.parse(tiempo[0]);
    final minuto = int.parse(tiempo[1]);


    return FeymanModel(
      id: id,
      titulo: data['titulo'] ?? '',
      tema: data['tema'] ?? '',
      explicacion: data['explicacion'] ?? '',
      dudas: data['dudas'] ?? '',
      ejemplos: data['ejemplos'] ?? '',
      hora: TimeOfDay(hour: hora, minute: minuto),
      fecha: DateTime.parse(data['fecha']),
    );
  }
}
