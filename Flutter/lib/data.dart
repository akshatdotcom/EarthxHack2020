import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  Firestore firestore = Firestore();
  var users = new List();

  Data() {
    initializeData();
  }

  void initializeData() {
    users.clear();
    firestore.collection("users").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => users.add(f.data));
    });
  }

  void addUser(String username, String password, double score, String achievements, double aElectric, double pElectric, double aNG, double pNG, double aCar, double pCar) {
    Map<String, String> user = {"username": username, "password": password, "score": score.toString(), "achievements": achievements, "eElectric": aElectric.toString(), "pElectric": pElectric.toString(), "aNG": aNG.toString(), "pNG": pNG.toString(), "aCar": aCar.toString(), "pCar": pCar.toString()};
    firestore.collection("users").document(username).setData(user);
    initializeData();
  }

  Object getData(String username, String query) {
    for (int i = 0; i < users.length; i++) {
      if (users[i]['username'] == username) return users[i][query];
    }
  }

  List getUsers() {
    var tempUsers = users;
    tempUsers.sort((m1, m2) {
      return double.parse(m1["score"]).compareTo(double.parse(m2["score"]));
    });
    var leaderboard = List.generate(users.length-1, (i) => List(tempUsers.length), growable: false);
    for (int i = 0; i < tempUsers.length; i++) {
      leaderboard[0][i] = tempUsers[i]["username"];
      leaderboard[1][i] = i+1;
    }
    return leaderboard;
  }
}
