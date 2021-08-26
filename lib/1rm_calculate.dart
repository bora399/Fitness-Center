import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OneRMPage extends StatefulWidget {
  Color background, text;
  bool english;
  OneRMPage({this.background, this.text, this.english});

  @override
  _OneRMPageState createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage> {
  double weight;
  int reps;
  var result;

  TextEditingController _weightController = TextEditingController();
  TextEditingController _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.background,
        appBar: AppBar(
          title: Text(
              widget.english == true ? "Calculate Your 1RM" : "1RM'ini Hesapla",
              style: GoogleFonts.rubik(
                  textStyle:
                      TextStyle(fontSize: 24, color: widget.background))),
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
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Text(
                  widget.english == true
                      ? "Your weight must be lower than 500 and your reps must be lower than 16"
                      : "Kilo 500'den az olmalı ve tekrar sayıları 16'dan az olmalı",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(fontSize: 20, color: widget.text))),
            ),
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
              controller: _repsController,
              decoration: InputDecoration(
                labelText: widget.english == true
                    ? "Reps in integer"
                    : "Tam sayı cinsinden tekrar sayısı",
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
            Builder(builder: (ctx) {
              return RaisedButton(
                color: widget.text,
                child: Text(
                  widget.english == true ? "Calculate" : "Hesapla",
                  style: GoogleFonts.rubik(
                      textStyle:
                          TextStyle(fontSize: 20, color: widget.background)),
                ),
                onPressed: () async {
                  setState(() {
                    reps = int.parse(_repsController.text);
                    weight = double.parse(_weightController.text);
                    if (reps > 15 || weight > 500) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (_, __, ___) => OneRMPage(
                              background: widget.background, text: widget.text),
                        ),
                      );
                    }
                    result = weight * (36 / (37 - reps));
                    result = result.round();
                    result = result.toString();
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
                  : "1x" + result,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 20, color: widget.text)),
            ),
          ],
        ),
      ),
    );
  }
}
