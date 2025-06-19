import 'package:app2/models/feyman_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Crear un funcion
//Recibir un id
//Recibir un map (representa el doc de firebase)
//Retorna una instancia de mi modelo
typedef FromMap<T> = T Function(String id, Map<String, dynamic> data);

//La clase puede recibir cualquier modelo
class FirestoreService<T> {
  final String collection;
  final FromMap<T> fromMap;
  final _db = FirebaseFirestore.instance;

  FirestoreService({required this.collection, required this.fromMap});

  //CRUD
  //POST
  //Recibir un modelo,
  //Recibe una funcion sin paramtros que devuelve un map, osea el json del modelo
  Future<void> post(T model, Map<String, dynamic> Function() toMap) async {
    await _db.collection(collection).add(toMap());
  }
  //GETALL
  //GETID
  //UPDATE
  //DELETE

/*
  Future<List<FeymanModel>> getFichas() async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs.map((doc) => FeymanModel.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> updateFicha(FeymanModel ficha) async {
    await _db.collection(collection).doc(ficha.id).update(ficha.toMap());
  }

  Future<void> deleteFicha(String id) async {
    await _db.collection(collection).doc(id).delete();
  }
*/
}
