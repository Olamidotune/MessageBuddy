import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});

//reference for the collection.
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  //saving userData
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullname': fullName,
      'email': email,
      'groups': [],
      'profilePicture': '',
      'uid': uid
    });
  }

//getting userData

  Future gettingUserData(String email) async {
    QuerySnapshot snapShot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapShot;
  }
}
