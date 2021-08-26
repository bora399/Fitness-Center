import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyFatPage extends StatefulWidget {
  Color background;
  Color text;
  bool english;

  BodyFatPage({this.background, this.text, this.english});

  @override
  _BodyFatPageState createState() => _BodyFatPageState();
}

class _BodyFatPageState extends State<BodyFatPage> {
  //Bodyfat for men : 86.010*log10(bel-boyun) - 70.041*log10(height) + 36.76
  //Bodyfat for women : 163.205*log10*(bel+kalça-boyun) - 97.684*(log10*(height)) - 78.387
  double log10(num x) => log(x) / ln10;
  double abdomen;
  double neck;
  double height;
  double waist;
  double hip;
  String result;

  TextEditingController _heightController = new TextEditingController();
  TextEditingController _abdomenController = new TextEditingController();
  TextEditingController _neckController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: widget.background,
          appBar: AppBar(
            title: Text(
                widget.english == true
                    ? "Calculate Your Body Fat"
                    : "Vücut Yağınızı Hesaplayın",
                style: GoogleFonts.rubik(
                    textStyle:
                        TextStyle(fontSize: 22, color: widget.background))),
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
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Text(
                    widget.english == true
                        ? "All of the arguments must be higher than 0, otherwise, the screen will be restarted"
                        : "Tüm argümanlar 0'dan büyük olmalıdır, aksi takdirde ekran yeniden başlatılacaktır",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                        textStyle:
                            TextStyle(fontSize: 18.5, color: widget.text))),
              ),
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
              SizedBox(height: 20),
              TextField(
                controller: _abdomenController,
                decoration: InputDecoration(
                  labelText: widget.english == true
                      ? "Abdomen in cm"
                      : "Cm cinsinden karın",
                  labelStyle: GoogleFonts.rubik(
                      textStyle: TextStyle(color: widget.text, fontSize: 18)),
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.line_weight, color: widget.text),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _neckController,
                decoration: InputDecoration(
                  labelText: widget.english == true
                      ? "Neck in cm"
                      : "Cm cinsinden boyun",
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
              RaisedButton(
                color: widget.text,
                child: Text(
                  widget.english == true ? "Calculate" : "Hesapla",
                  style: GoogleFonts.rubik(
                      textStyle:
                          TextStyle(fontSize: 20, color: widget.background)),
                ),
                onPressed: () async {
                  setState(() {
                    height = double.parse(_heightController.text);
                    abdomen = double.parse(_abdomenController.text);
                    neck = double.parse(_neckController.text);
                    if (height <= 0 || abdomen <= 0 || neck <= 0) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (_, __, ___) => BodyFatPage(
                              background: widget.background, text: widget.text),
                        ),
                      );
                    }
                    result = (86.010 * log10(abdomen - neck) -
                            70.041 * log10(height) +
                            36.76)
                        .toString();
                  });
                },
              ),
              SizedBox(height: 15),
              Text(
                result == null
                    ? widget.english == true
                        ? "Enter Value"
                        : "Değer Giriniz"
                    : result,
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(fontSize: 20, color: widget.text)),
              ),
            ],
          )),
    );
  }
}
