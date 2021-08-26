import 'package:firebase_blog/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  Color background;
  Color text;
  bool english2;

  SettingsPage({
    this.background,
    this.text,
    this.english2,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool english;
  void initState() {
    english = english == null ? true : english;
    widget.english2 = widget.english2 == null ? true : widget.english2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome To The Settings Page",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 18, color: widget.text))),
          centerTitle: true,
          elevation: 0,
          backgroundColor: widget.background,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(english: english)),
                );
              },
              icon: Icon(Icons.arrow_back),
              color: widget.text),
        ),
        body: Container(
          child: SwitchListTile(
            value: widget.english2,
            onChanged: (bool englishBool) {
              setState(() {
                widget.english2 = englishBool;
                english = widget.english2;
              });
            },
            title: Text(english == true ? "English" : "Turkish"),
            subtitle: Text(
              english == true ? "Turkish" : "English",
            ),
            secondary: Icon(Icons.language),
          ),
        ),
      ),
    );
  }
}
