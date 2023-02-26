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

  // getting user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // create a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      'groupName': groupName,
      'admin': '${id}_$userName',
      'members': [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
      'groupICon': '',
    });

    //update the members
    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(["${uid}_$userName"]),
      'groupId': groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'groups': FieldValue.arrayUnion(
        ['${groupDocumentReference.id}_$groupName'],
      ),
    });
  }
}
