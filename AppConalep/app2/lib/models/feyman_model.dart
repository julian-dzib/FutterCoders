class FeymanModel {
  String id;
  String titulo;
  String tema;
  String explicacion;
  String dudas;
  String ejemplos;
  
  

  FeymanModel({
    required this.id,
    required this.titulo,
    required this.tema,
    required this.explicacion,
    required this.dudas,
    required this.ejemplos,
  });

  //Convierte tu objeto Dart (modelo) en un mapa tipo JSON (Map<String, dynamic>).
  //Cuando guardas en Firestore/API

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'tema': tema,
      'explicacion': explicacion,
      'dudas': dudas,
      'ejemplos': ejemplos,
    };
  }
  //Hace lo inverso: convierte un mapa JSON (Map<String, dynamic>) en un objeto Dart (modelo).
  //Cuando lees de Firestore/API
  factory FeymanModel.fromMap(String id, Map<String, dynamic> data) {
    return FeymanModel(
      id: id,
      titulo: data['titulo'] ?? '',
      tema: data['tema'] ?? '',
      explicacion: data['explicacion'] ?? '',
      dudas: data['dudas'] ?? '',
      ejemplos: data['ejemplos'] ?? '',
    );
  }
}
