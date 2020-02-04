
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIform(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  var currencies = ['Rupees', 'Dollar', 'Pound'];
  final double minpadding = 5.0;
  var current_currency = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var final_result = '';

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
          backgroundColor: Colors.black,
        ),
        body: Form(
            key:formkey,
            //margin: EdgeInsets.all(minpadding * 2),
            child: Padding(
                padding: EdgeInsets.all(minpadding * 2),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                        padding: EdgeInsets.all(minpadding),
                        child: TextFormField(
                          //autovalidate: true,
                          keyboardType: TextInputType.number,
                          controller: principalController,
                          style: textStyle,
                          validator: (String value ) {
                            if (value.isEmpty || int.tryParse(value)==null) {
                              return 'please enter the principal amount and only number';
                            }
                          },
//                          validator: (input) {
//                            final isDigitsOnly = int.tryParse(input);
//                            return isDigitsOnly == null
//                                ? 'Input needs to be digits only'
//                                : null;
//                          },
                          decoration: InputDecoration(
                              labelText: 'Principal',
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15),
                              hintText: 'Enter the principal amount e.g. 10000',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Padding(
                        padding: EdgeInsets.all(minpadding),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: roiController,
                          style: textStyle,
                          validator: (String value) {
                            if (value.isEmpty || int.tryParse(value)==null) {
                              return 'please enter the rate of interest and only number';
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15),
                              labelText: 'Rate of intrest',
                              hintText: 'in percent',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: minpadding, bottom: minpadding),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: timeController,
                              style: textStyle,
                              validator: (String value) {
                                if (value.isEmpty || int.tryParse(value)==null) {
                                  return 'please enter the time and only number';
                                }
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.yellowAccent, fontSize: 15),
                                  labelText: 'Term',
                                  hintText: 'Time in years',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                            Container(
                              width: minpadding * 5,
                            ),
                            Expanded(
                                child: DropdownButton<String>(
                              items: currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: current_currency,
                              style: textStyle,
                              onChanged: (String newValueSelected) {
                                // Your code to execute, when a menu item is selected from dropdown
                                //_onDropDownItemSelected(newValueSelected);
                                setState(() {
                                  this.current_currency = newValueSelected;
                                });
                              },
                            ))
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: minpadding, top: minpadding),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Colors.black,
                                child: Text(
                                  'Calculate',
                                  style: TextStyle(color: Colors.white),
                                  textScaleFactor: 1.2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if(formkey.currentState.validate()) {
                                      this.final_result = calculate_result();
                                    }});
                                },
                              ),
                            ),
                            Container(
                              width: minpadding * 5,
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text(
                                  'Reset',
                                  style: TextStyle(color: Colors.black),
                                  textScaleFactor: 1.2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    reset();
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.all(minpadding * 2),
                      child: Text(
                        this.final_result,
                        style: TextStyle(color: Colors.grey),
                        textScaleFactor: 1.2,
                      ),
                    )
                  ],
                ))));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('image/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(minpadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.current_currency = newValueSelected;
    });
  }

  String calculate_result() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double time = double.parse(timeController.text);

    double total_amount = principal + (principal * roi * time) / 100;
    String result =
        'After $time years, your investment will be worth $total_amount $current_currency';
    return result;
  }

  void reset() {
    principalController.text = '';
    roiController.text = '';
    timeController.text = '';
    final_result = '';
    current_currency = currencies[0];
  }
}
