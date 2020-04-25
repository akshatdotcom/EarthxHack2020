import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double calculateCF(double home, double heat, double car, double train, double bus) {
    return (2*home*1.37*0.033);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('You used '),
          InputContainer("Hours home: ", 5.0),
          InputContainer("Hours heating: ", 5.0),
          InputContainer("Hours hot water: ", 5.0),
          InputContainer("Miles in car: ", 5.0),
          InputContainer("Miles in train or similar: ", 5.0),
          InputContainer("Miles in bus: ", 5.0),
        ],
      ),
    );
  }
}

class InputContainer extends StatefulWidget {
  final String title;
  final double max;
  InputContainer(this.title, this.max);

  @override
  _InputContainerState createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Text(widget.title + _value.toString()),
          Slider(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = double.parse((value).toStringAsFixed(2));
              });
            },
            max: widget.max,
          )
        ],
      ),
    );
  }
}
