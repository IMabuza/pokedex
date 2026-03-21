import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthUser?> signIn(String email, String password) async {
    try{
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthUser(email: result.user!.email!, uid: result.user!.uid);
    }catch(e){
      rethrow;
    }
  }

   Future<AuthUser?> register(String email, String password) async {
    try{
      final result = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
      return AuthUser(email: result.user!.email!, uid: result.user!.uid);
    }catch(e){
      rethrow;
    }
  }
}