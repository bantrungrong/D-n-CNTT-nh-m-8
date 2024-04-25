// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class LoginAccount{
//   final FirebaseAuth _firebaseAuth;
//   LoginAccount(this._firebaseAuth);
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
//   Future<String> signIn(
//   {required String email,required String password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(email:email,password:password);
//       return "sign In";
//     } on FirebaseAuthException catch (e){
//       return e.message.toString();
//     }
//   }
// }