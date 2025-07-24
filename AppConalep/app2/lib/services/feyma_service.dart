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
  //Definir 
  final FromMap<T> fromMap;
  final _db = FirebaseFirestore.instance;

  FirestoreService({required this.collection, required this.fromMap
  });

  //CRUD
  //POST
  //Recibir un modelo,
  //Recibe una funcion sin paramtros que devuelve un map, osea el json del modelo
  Future<void> post(T model, Map<String, dynamic> Function() toMap) async {
    await _db.collection(collection).add(toMap());
  }
  //GETALL
  Future<List<T>> get() async {
    final service= await _db.collection(collection).get();
    //Hay que retornar mi documento de firestore para despues retornar una lista
    return service.docs
      .map((doc)=> fromMap(doc.id,doc.data()))
      .toList();
  }
  //GETID
  //UPDATE
  Future<void> update(String id, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(id).update(data);
  }
  //DELETE
  Future<void> delete (String id) async{
    await _db.collection(collection).doc(id).delete();
  }

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
