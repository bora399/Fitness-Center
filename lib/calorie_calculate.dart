import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaloriePage extends StatefulWidget {
  Color background;
  Color text;
  bool english;

  CaloriePage({this.background, this.text, this.english});

  @override
  _CaloriePageState createState() => _CaloriePageState();
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class _CaloriePageState extends State<CaloriePage> {
  double weight;
  int height;
  double workoutTime = 1.2;
  int age;
  var result;
  //66.5 + 13.8 * (weight) + 5 * (height) / 6.8 * age
  //655.1 + 9.6 *(weight) + 1.9 * (height) / 4.7 * age

  int _value = 1;

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ListItem> _dropdownItems = [
      ListItem(
          1,
          widget.english == true
              ? "1-3 Workouts per week"
              : "Haftada 1-3 antrenman"),
      ListItem(
          2,
          widget.english == true
              ? "3-5 Workouts per week"
              : "Haftada 3-5 antrenman"),
      ListItem(
          3,
          widget.english == true
              ? "5-7 Workouts per week"
              : "Haftada 5-7 antrenman"),
    ];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.background,
        appBar: AppBar(
          title: Text(
              widget.english == true
                  ? "Calculate Calories You Need"
                  : "İhtiyacın Olan Kaloriyi Hesapla",
              style: GoogleFonts.rubik(
                  textStyle:
                      TextStyle(fontSize: 18, color: widget.background))),
          centerTitle: true,
          elevation: 0,
          backgroundColor: widget.text,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: widget.background),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                  widget.english == true
                      ? "Weight must be lower than 400 and height must be lower than 250, otherwise, the application will be restarted"
                      : "Kilo 400'den boy 250'den az olmalıdır, aksi takdirde ekran yeniden başlatılacaktır",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      textStyle:
                          TextStyle(fontSize: 18.5, color: widget.text))),
            ),
            Container(
              child: DropdownButton(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.sports_basketball,
                    color: widget.text,
                  ),
                ),
                hint: Text(
                    widget.english == true
                        ? "Choose your workout frequency"
                        : "Antrenman sıklığınızı seçiniz",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                        textStyle:
                            TextStyle(fontSize: 13.99, color: widget.text))),
                dropdownColor: widget.background,
                value: _value,
                items: _dropdownItems.map((ListItem item) {
                  return DropdownMenuItem<int>(
                    child: Text(item.name,
                        style: GoogleFonts.rubik(
                            textStyle:
                                TextStyle(fontSize: 19.8, color: widget.text))),
                    value: item.value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    value = value.toString();
                    if (value == "1") {
                      workoutTime = 1.2;
                    } else if (value == "2") {
                      workoutTime = 1.3;
                    } else if (value == "3") {
                      workoutTime = 1.4;
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: widget.english == true
                    ? "Weight in kg"
                    : "Kg cinsinden ağırlık",
                labelStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color: widget.text, fontSize: 18)),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.line_weight,
                    color: widget.text,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: widget.english == true
                    ? "Age in integer"
                    : "Tam sayı cinsinden yaş",
                labelStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color: widget.text, fontSize: 18)),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.trending_up,
                    color: widget.text,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: widget.english == true
                    ? "Height in cm"
                    : "Cm cinsinden boy",
                labelStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color: widget.text, fontSize: 18)),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.trending_up,
                    color: widget.text,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Builder(
              builder: (ctx) {
                return RaisedButton(
                  color: widget.text,
                  child: Text(
                    widget.english == true ? "Calculate" : "Hesapla",
                    style: GoogleFonts.rubik(
                        textStyle:
                            TextStyle(fontSize: 20, color: widget.background)),
                  ),
                  onPressed: () async {
                    setState(
                      () {
                        height = int.parse(_heightController.text);
                        weight = double.parse(_weightController.text);
                        if (height > 250 ||
                            weight > 400 ||
                            height <= 0 ||
                            weight <= 0) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration.zero,
                              pageBuilder: (_, __, ___) => CaloriePage(
                                  background: widget.background,
                                  text: widget.text),
                            ),
                          );
                        }
                        age = int.parse(_ageController.text);
                        result =
                            ((10 * (weight) + 6.25 * (height) - 5 * (age) + 5) *
                                    workoutTime)
                                .toString();
                        List resultList = result.split(".");
                        result = resultList[0];
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 15),
            Text(
              result == null
                  ? widget.english == true
                      ? "Enter Value"
                      : "Değer Giriniz"
                  : result + " " + "cal",
              //result == null ? "Enter Value" : result,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 20, color: widget.text)),
            ),
          ],
        ),
      ),
    );
  }
}
