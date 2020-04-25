import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//final textEditingController = TextEditingController();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double cf = 0.0;

  double calculateCF(double aElectric, double pElectric, double aNG, double pNG,
      double aCar, pCar) {
    return ((aElectric / pElectric) * 1.37) +
        ((aNG / pNG) * 120.61) +
        ((aCar / pCar) * 19.4 * (100 / 95));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('You used ' + cf.toString()),
          InputContainerHouse("Elctectricity bill per month", "Price per kWh", this),
          InputContainerHouse(
              "Natural gas bill per month", "Price per 1000 ft^3", this),
          InputContainerHouse("Miles driven per month", "MPG", this),
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

class InputContainerHouse extends StatefulWidget {
  final String title;
  final String units;
  final _HomePageState parent;
  InputContainerHouse(this.title, this.units, this.parent);

  @override
  _InputContainerHouseState createState() => _InputContainerHouseState();
}

class _InputContainerHouseState extends State<InputContainerHouse> {
  void updateCF(String input) {
    widget.parent.setState(() {
      widget.parent.cf = double.parse(input);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              //controller: textEditingController,
              decoration: InputDecoration(
                labelText: (widget.title),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSubmitted: updateCF,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: (widget.units),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
    );
  }
}
