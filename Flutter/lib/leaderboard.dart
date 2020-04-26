import 'package:flutter/material.dart';
import 'data.dart';
import 'globals.dart' as globals;

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}
class _LeaderboardPageState extends State<LeaderboardPage> {

  static final Data data = Data();
  _LeaderboardPageState() {
    var leaderboard = data.getUsers();
    globals.leaderboardItems.clear();
    for(int i = 0; i < leaderboard.length+1; i++) {
      globals.leaderboardItems.add(LeaderboardItem(leaderboard[0][i], leaderboard[1][i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: globals.leaderboardItems,
        ),
      ),
    );
  }
}

class LeaderboardItem extends StatefulWidget {
  final String user;
  final int place;
  LeaderboardItem(this.user, this.place);
  @override
  _LeaderboardItemState createState() => _LeaderboardItemState();
}

class _LeaderboardItemState extends State<LeaderboardItem> {
  Color bgColor;
  @override
  Widget build(BuildContext context) {
    if (widget.place == 1) {
      bgColor = Colors.orange[300];
    } else if (widget.place == 2) {
      bgColor = Colors.grey;
    } else if (widget.place == 3) {
      bgColor = Colors.brown[300];
    } else {
      bgColor = Colors.grey[400];
    }
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Text(
              widget.user,
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              widget.place.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
