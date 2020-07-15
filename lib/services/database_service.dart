import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_crew/models/coffee.dart';
import 'package:coffee_crew/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  static const String _firestoreCollectionName = 'coffees';
  //reference to a collection
  final CollectionReference coffeeCollection =
      Firestore.instance.collection(_firestoreCollectionName);

  Future updateUserData(String sugars, String name, int strength) async {
    await coffeeCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // coffee list from a snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Coffee(
            name: doc?.data['name'] ?? '',
            sugars: doc?.data['sugars'] ?? '0',
            strength: doc?.data['strength'] ?? 0))
        .toList();
  }

  // get coffees stream
  Stream<List<Coffee>> get coffees {
    return coffeeCollection.snapshots().map((_coffeeListFromSnapshot));
  }

  // get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapShot);
  }

// user data from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) => UserData(
        uid: uid,
        name: documentSnapshot?.data['name'],
        sugars: documentSnapshot?.data['sugars'],
        strength: documentSnapshot?.data['strength'],
      );
}
