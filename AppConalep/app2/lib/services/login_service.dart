import 'package:firebase_auth/firebase_auth.dart';
class LoginService {
    String email;
    String password;

    LoginService({
      required this.email,
      required this.password
    });

    //Metodo para registrar usuario
    Future<void> registrarUsuarioConEmailYContrasenia() async {
    //Metodo para registrar usuario con email y contrasenia
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );
        print('Usuario registrado exitosamente: ${credential.user?.email}');
      } on FirebaseAuthException  catch (e){
            if(e.code == 'weak-password'){
              print('La contrasenia es muy debil');
            }else if(e.code == 'email-already-in-use'){
              print('Existe una cuenta asociada con ese email');
            }else if(e.code == 'invalid-email'){
              print('Error desconocido: ${e.message}');
            }
      }catch (e){
        print(e);
      }
    }
    Future<void> iniciarSesionConEmailYContrasenia() async {
    //Metodo para iniciar sesion con email y contrasenia
    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      print('Usuario logueado exitosamente: ${credential.user?.email}');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No existe una cuenta asociada con ese email');
      } else if (e.code == 'wrong-password') {
        print('La contrasenia es incorrecta');
      } else {
        print('Error desconocido: ${e.message}');
      }
    } catch (e) {
      print(e);
    }
  
  }

}