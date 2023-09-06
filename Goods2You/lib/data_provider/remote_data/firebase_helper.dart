import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper{

  FirebaseAuth auth=FirebaseAuth.instance;

  Future<dynamic>Signup(String email,String password,String name) async{
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser!.updateDisplayName(name);
      await auth.currentUser!.reload();
      if (user.user != null)
        return user.user;
    }
    on FirebaseAuthException catch(e)
    {
       if(e.code=='email-already-in-use')
         return "email already used";
       else if(e.code=='weak-password')
         return "password is too weak";
    }
  }

  Future<dynamic>Signin(String email,String password) async{
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null)
        return user.user;
    }
    on FirebaseException catch(e)
    {
        return e.message;
    }
  }

  Future<void> Signout() async{
   await auth.signOut();
  }

}