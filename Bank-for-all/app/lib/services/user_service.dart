import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user/user.dart';
import '../utils/setup_locator.dart';
import 'shared_prefs.dart';

class UserService {
  final Firestore _db = Firestore.instance;
  final SharedPrefs user = locator<SharedPrefs>();
  CollectionReference ref;

  UserService() {
    ref = _db.collection("users");
  }

  Future<DocumentSnapshot> getUserData() async {
    await user.getUser();
    return ref.document(user.authID).get();
  }

  Future<void> setUserData(User userModel) {
    return ref.document(userModel.id).setData(userModel.toJson(), merge: true);
  }
}
