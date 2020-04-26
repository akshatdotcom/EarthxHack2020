import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'globals.dart' as globals;

//final textEditingController = TextEditingController();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double cf = 0.0;
  double aElectric = 0, pElectric = 0, aNG = 0, pNG = 0, aCar = 0, pCar = 0;

  double calculateCF(double aElectric, double pElectric, double aNG, double pNG, double aCar, double pCar) {
    return ((aElectric / pElectric) * 1.37) + ((aNG / pNG) * 120.61) + ((aCar / pCar) * 19.4 * (100 / 95));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_left),
                  Text(
                    'Current month',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.arrow_right),
                ],
              ),
            ),
            Text(
              cf.toStringAsFixed(2),
              style: TextStyle(fontSize: 30),
            ),
            Text('pounds of CO2 emissions'),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Scan Item',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Stats',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InputContainerHouse("Electricity bill", "Price per kWh", this, 1),
            InputContainerHouse("Natural gas bill", "Price per 1000 ft³", this, 2),
            InputContainerHouse("Miles driven", "MPG", this, 3),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text("Logout"),
            ),
          ],
        ),
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
  final int id;
  InputContainerHouse(this.title, this.units, this.parent, this.id);

  @override
  _InputContainerHouseState createState() => _InputContainerHouseState();
}

class _InputContainerHouseState extends State<InputContainerHouse> {
  Data data = Data();
  void updateCF(String input) {
    widget.parent.setState(() {
      switch (widget.id) {
        case 1:
          widget.parent.aElectric = double.parse(input);
          break;
        case 2:
          widget.parent.aNG = double.parse(input);
          break;
        case 3:
          widget.parent.aCar = double.parse(input);
          break;
        default:
          print("switch case default in home.dart");
          break;
      }
      
      widget.parent.cf = widget.parent.calculateCF(
          widget.parent.aElectric, widget.parent.pElectric, widget.parent.aNG, widget.parent.pNG, widget.parent.aCar, widget.parent.pCar);
      data.addUser(globals.currentUser, data.getData(globals.currentUser, "password"), widget.parent.cf, "0", widget.parent.aElectric, widget.parent.pElectric, widget.parent.aNG, widget.parent.pNG, widget.parent.aCar, widget.parent.pCar);
    });
  }

  void updateCF2(String input) {
    widget.parent.setState(() {
      switch (widget.id) {
        case 1:
          widget.parent.pElectric = double.parse(input);
          break;
        case 2:
          widget.parent.pNG = double.parse(input);
          break;
        case 3:
          widget.parent.pCar = double.parse(input);
          break;
        default:
          print("switch case default in home.dart");
          break;
      }
      
      widget.parent.cf = widget.parent.calculateCF(
          widget.parent.aElectric, widget.parent.pElectric, widget.parent.aNG, widget.parent.pNG, widget.parent.aCar, widget.parent.pCar);
      data.addUser(globals.currentUser, data.getData(globals.currentUser, "password"), widget.parent.cf, "0", widget.parent.aElectric, widget.parent.pElectric, widget.parent.aNG, widget.parent.pNG, widget.parent.aCar, widget.parent.pCar);
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
              //inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              onChanged: updateCF,
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
              //inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              onChanged: updateCF2,
            ),
          ),
        ],
      ),
    );
  }
}
