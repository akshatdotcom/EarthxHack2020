import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  Firestore firestore = Firestore();
  Map<String, String> user = {"first": "firstname", "last": "lastname"};
  void setData() {
    firestore.collection("users").add(user);
  }

  void getData() {
    firestore.collection("users").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}
