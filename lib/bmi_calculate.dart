import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIPage extends StatefulWidget {
  Color background2, text2;
  bool english;

  BMIPage({this.background2, this.text2, this.english});
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double weight;
  double height;
  var result;

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.background2,
        appBar: AppBar(
          title: Text(
              widget.english == true ? "Calculate your BMI" : "VKİ'ni hesapla",
              style: GoogleFonts.rubik(
                  textStyle:
                      TextStyle(fontSize: 24, color: widget.background2))),
          centerTitle: true,
          elevation: 0,
          backgroundColor: widget.text2,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: widget.background2),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: Text(
                  widget.english == true
                      ? "Weight must be lower than 400 and height must be lower than 250, otherwise, the screen will be restarted"
                      : "Ağırlık 400'den, boy ise 250 cm'den az olmalı. Aksi takdirde ekran yeniden başlatılacaktır",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(fontSize: 22, color: widget.text2))),
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: widget.english == true
                    ? "Weight in kg"
                    : "Kg cinsinden ağırlık",
                labelStyle: GoogleFonts.rubik(
                    textStyle: TextStyle(color: widget.text2, fontSize: 21)),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.line_weight,
                    color: widget.text2,
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
                    textStyle: TextStyle(color: widget.text2, fontSize: 21)),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.trending_up,
                    color: widget.text2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Builder(builder: (ctx) {
              return RaisedButton(
                color: widget.text2,
                child: Text(
                  widget.english == true ? "Calculate" : "Hesapla",
                  style: GoogleFonts.rubik(
                      textStyle:
                          TextStyle(fontSize: 20, color: widget.background2)),
                ),
                onPressed: () async {
                  setState(() {
                    height = double.parse(_heightController.text);
                    weight = double.parse(_weightController.text);
                    if (height > 250 ||
                        weight > 400 ||
                        height <= 0 ||
                        weight <= 0) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (_, __, ___) => BMIPage(
                              background2: widget.background2,
                              text2: widget.text2),
                        ),
                      );
                    }
                    result = weight / (pow((height / 100), 2));
                    result = result.toString();
                    if (result.length <= 4) {
                      result = result;
                    } else {
                      result = result[0] + result[1] + result[2] + result[3];
                    }
                    //if (result.length > 4) {
                    //  result = result[0] + result[1] + result[2] + result[3];
                    //} else {
                    //  result = result;
                    //}
                  });
                },
              );
            }),
            SizedBox(height: 15),
            Text(
              result == null
                  ? widget.english == true
                      ? "Enter Value"
                      : "Değer Giriniz"
                  : result,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 20, color: widget.text2)),
            ),
          ],
        ),
      ),
    );
  }
}
