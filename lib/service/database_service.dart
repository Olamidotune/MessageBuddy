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

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // getting the groupMembers
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

//search by groupName
  searchByName(String groupName) {
    return groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  // Function that shows if the user is joined in a group
  Future<bool> isUserJoined(
    String groupId,
    String groupName,
    String userName,
  ) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains('${groupId}_$groupName')) {
      return true;
    } else {
      return false;
    }
  }

  //joining the group/exit the group.
  Future toggleGroupJoin(
      String userName, String groupId, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains('${groupId}_$groupName')) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(['${groupId}_$groupName'])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayRemove(['${uid}_$userName'])
      });
    } else {
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
      });
      {
        await groupDocumentReference.update({
          'members': FieldValue.arrayUnion(['${uid}_$userName'])
        });
      }
    }
  }
}
