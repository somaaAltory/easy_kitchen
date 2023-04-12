
import 'package:firebase_auth/firebase_auth.dart';

class User {
  static late User _instance;
   late String userId;

  User._internal()
  {
    userId = (FirebaseAuth.instance.currentUser?.uid!) as String;
  }

  static User get getUserId {
    _instance ??= User._internal();
    return _instance;
  }
}


