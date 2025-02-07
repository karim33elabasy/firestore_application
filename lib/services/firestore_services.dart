import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_example/models/user_model.dart';

abstract class FirestoreServices{
  static final _firestore = FirebaseFirestore.instance;
  static final String collectionName = 'users';
  
  static Future<String> addUserToFirestore(UserModel userModel) async {
    try {
      await _firestore.collection(collectionName).add(userModel.toJson());
      return 'User added successfully';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  static Future<List<UserModel>> getAllUsers() async {
    var data = await _firestore.collection(collectionName).get();
    return data.docs.map((userData) => UserModel.fromJson(userData)).toList();
  }
}
