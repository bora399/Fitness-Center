import 'package:firebase_blog/bodyfat_man.dart';
import 'package:firebase_blog/bodyfat_woman.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SexChoosePage extends StatelessWidget {
  Widget male;
  Widget female;
  Color text;
  Color background;
  bool english;

  SexChoosePage(
      {this.male, this.female, this.text, this.background, this.english});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text(
              english == true ? "Choose Your Sex" : "Cinsiyetinizi Seçiniz",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 24, color: background))),
          centerTitle: true,
          elevation: 0,
          backgroundColor: text,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: background),
        ),
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              children: <Widget>[
                SizedBox(height: 70.0),
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(
                        top: 7.0, bottom: 7.0, right: 10.0, left: 1.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => male),
                      );
                    },
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 100, right: 100, top: 15, bottom: 15),
                            child: new Text(
                              english == true ? "Male" : "Erkek",
                              style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                      fontSize: 33, color: background)),
                            ))
                      ],
                    ),
                    textColor: Color(0xFF292929),
                    color: text),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding: EdgeInsets.only(
                          top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => female),
                        );
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 80, right: 80, top: 15, bottom: 15),
                              child: new Text(
                                english == true ? "Female" : "Kadın",
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        fontSize: 33, color: background)),
                              ))
                        ],
                      ),
                      textColor: Color(0xFF292929),
                      color: text),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
