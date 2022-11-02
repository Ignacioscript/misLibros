import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mis_libros/models/user.dart' as UserApp;

class FireBaseApi{

Future<String?> registerUser(String email, String password) async{

  try{
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  } on FirebaseAuthException catch(e){
    print("FirebaseAuthException ${e.code}");
    return e.code;
  }
    on FirebaseException catch (e){
    print("FirebaseException ${e.code}");
    return e.code;
  }



}

  Future<String?> loginUser(String email, String password) async{
     try{
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  } on FirebaseAuthException catch(e){
    print("FirebaseAuthException ${e.code}");
    return e.code;
  }
    on FirebaseException catch (e){
    print("FirebaseException ${e.code}");
    return e.code;
  }

  }

  Future<Object> createUser(UserApp.User user) async {
    try{
      final document = await FirebaseFirestore.instance.collection("users").doc(user.uid).set(user.ToJson());
      return user.uid;
    }on FirebaseException catch(e){
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

}

