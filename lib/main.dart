import 'package:firebase_blog/1rm_calculate.dart';
import 'package:firebase_blog/bmi_calculate.dart';
import 'package:firebase_blog/bodyfat_man.dart';
import 'package:firebase_blog/bodyfat_sex_page.dart';
import 'package:firebase_blog/bodyfat_woman.dart';
import 'package:firebase_blog/calorie_calculate.dart';
import 'package:firebase_blog/calorie_calculate_women.dart';
import 'package:firebase_blog/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  bool english;
  HomePage({this.english});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool english2;
  Color background = Color(0xFFB92243);
  Color text = Color(0xFFF5F1F2);
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  RiveAnimationController _controller;
  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);
  bool get isPlaying => _controller.isActive;
  String iconCode = "e0cd";

  SharedPreferences sharedPreferences;

  void initState() {
    english2 = widget.english;
    //widget.english = widget.english == null ? true : widget.english;
    //widget.english = widget.english == null ? widget.english : english2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.english == true
                  ? "Welcome To Your Fitness Center"
                  : "Fitness Merkezine Hoş Geldin",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 18, color: background))),
          centerTitle: true,
          elevation: 0,
          backgroundColor: text,
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              background: background,
                              text: text,
                              english2: english2,
                            )),
                  );
                },
                icon: Icon(Icons.settings, color: background),
              );
            }),
          ],
        ),
        body: Container(
            color: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text(
                      widget.english == true
                          ? "You can check your body fat, BMI, The calories you need, and 1RM using this application"
                          : "Bu uygulamayı kullanarak vücut yağını, VKİ'ni, ihtiyacın olan kaloriyi ve 1RM'ini ölçebilirsin",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(fontSize: 22.8, color: text))),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 250),
                    child: RiveAnimation.asset(
                      'assets/basketball_riv.riv',
                    ),
                  ),
                ),
              ],
            )),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            ringColor: Colors.white.withAlpha(25),
            ringDiameter: 450.0,
            ringWidth: 120.0,
            fabSize: 64.0,
            fabElevation: 10.0,
            fabIconBorder: CircleBorder(),
            fabColor: text,
            fabOpenIcon: Icon(Icons.menu, color: background),
            fabCloseIcon: Icon(Icons.close, color: background),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SexChoosePage(
                            male: BodyFatPage(
                                background: background,
                                text: text,
                                english: widget.english),
                            female: BodyFatWoman(
                                background: background,
                                text: text,
                                english: widget.english),
                            background: background,
                            text: text,
                            english: widget.english)),
                  );
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Icon(FontAwesomeIcons.burn, color: text, size: 32),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BMIPage(
                            background2: background,
                            text2: text,
                            english: widget.english)),
                  );
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Text(widget.english == true ? "BMI" : "VKİ",
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: text, fontSize: 26))),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SexChoosePage(
                            male: CaloriePage(
                                background: background,
                                text: text,
                                english: widget.english),
                            female: CaloriePageWomen(
                                background: background,
                                text: text,
                                english: widget.english),
                            background: background,
                            text: text,
                            english: widget.english)),
                  );
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Icon(
                  Icons.fastfood,
                  color: text,
                  size: 32,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OneRMPage(
                            background: background,
                            text: text,
                            english: widget.english)),
                  );
                },
                shape: CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: Text("1RM",
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: text, fontSize: 26))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
