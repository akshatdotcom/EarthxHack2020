import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AchievementItem('Carbon Cop', 'Have a monthly carbon emission of less than 10,000 lbs.', true),
            AchievementItem('Carbon Fighter', 'Have a monthly carbon emission of less than 8,000 lbs.', true),
            AchievementItem('Carbon Warrior', 'Have a monthly carbon emission of less than 6,000 lbs.', true),
            AchievementItem('Carbon Ninja', 'Have a monthly carbon emission of less than 4,000 lbs.', true),
            AchievementItem('Carbon Destroyer', 'Have a monthly carbon emission of less than 2,000 lbs.', true),
            AchievementItem('Better than Most', 'Place in the top 50% at some point', true),
            AchievementItem('Better than Many', 'Place in the top 25% at some point', true),
            AchievementItem('Better than Almost Everyone', 'Place in the top 10% at some point', true),
            AchievementItem('Better than Everyone', 'Place in the top spot at some point', true),
          ],
        ),
      ),
    );
  }
}

class AchievementItem extends StatefulWidget {
  final String title;
  final String description;
  final bool complete;
  AchievementItem(this.title, this.description, this.complete);
  @override
  _AchievementItemState createState() => _AchievementItemState();
}

class _AchievementItemState extends State<AchievementItem> {
  Icon completeIcon;
  Color completeColor;
  @override
  Widget build(BuildContext context) {
    if (widget.complete) {
      completeIcon = Icon(Icons.check);
      completeColor = Colors.green;
    } else {
      completeIcon = Icon(Icons.close);
      completeColor = Colors.red;
    }
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: completeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: SizedBox(),
            ),
            completeIcon,
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(widget.title),
              content: Text(widget.description),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'))
              ],
            );
          });
      },
    );
  }
}
