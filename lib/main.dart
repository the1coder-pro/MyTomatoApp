import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/study': (context) => StudyPage(),
      },
    );
  }
}

class PreFrences extends InheritedWidget {
  final bool isEnglish;

  PreFrences({this.isEnglish, Widget child}) : super(child: child);

  bool updateShouldNotify(PreFrences oldWidget) =>
      oldWidget.isEnglish != isEnglish;

  static PreFrences of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType() as PreFrences;
}

//Global Variables
int repeatWords = 3;
double toolBarHeight = 70;
TextEditingController field = TextEditingController();
var theContent = '';
var listOfSentences;
double textHeight = 1;

class WordRepeatSlider extends StatefulWidget {
  @override
  _WordRepeatSliderState createState() => _WordRepeatSliderState();
}

class _WordRepeatSliderState extends State<WordRepeatSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
        inactiveColor: Colors.grey,
        activeColor: Colors.black,
        value: repeatWords.toDouble(),
        min: 3,
        max: 10,
        divisions: 9,
        label: '$repeatWords',
        onChanged: (double value) {
          setState(() {
            repeatWords = value.toInt();
          });
        });
  }
}

class TextHeightSlider extends StatefulWidget {
  @override
  _TextHeightSliderState createState() => _TextHeightSliderState();
}

class _TextHeightSliderState extends State<TextHeightSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
        inactiveColor: Colors.grey,
        activeColor: Colors.black,
        value: textHeight,
        min: 1,
        max: 5,
        divisions: 4,
        label: '${textHeight.toInt()}',
        onChanged: (double value) {
          setState(() {
            textHeight = value;
          });
        });
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            iconSize: 30,
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text("Settings", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: 60,
        ),
        body: ListView(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("English"),
            //     // TODO Fixing the Switch
            //     Switch(value: false, onChanged: (value) => value),
            //     Text("Arabic"),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Word Repeat"), WordRepeatSlider()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Text Height"), TextHeightSlider()],
            )
          ],
        ));
  }
}

void submitfunction(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/study');
  theContent = field.text;
  // theContent = theContent.toString().split("...").join(" ").split("  ")[0];
  var listOfSpliters = ["...", " *** ", ",", "،"];
  for (var spliter in listOfSpliters) {
    if (theContent.trim().contains(spliter)) {
      listOfSentences = theContent
          .toString()
          .trim()
          .split(spliter)
          .join(" ")
          .trim()
          .split("  ");
    }
  }

  // var theSpliters = {
  //   "threeDots": "...",
  //   "threeStars": "***",
  //   "Arabiccomma": "،",
  //   "comma": ","
  // };
  // String spliter;
  // if (theContent.contains("...")) {
  //   spliter = "...";
  //   print(theContent.toString().split(spliter).join(" ").split("  "));
  //   theContent = theContent.toString().split(spliter).join(" ").split("  ")[0];
  // } else {
  //   //TODO Theres No Dialog
  //   print("No Text");
  // }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              Text("Home", style: TextStyle(color: Colors.black, fontSize: 25)),
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: toolBarHeight,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              iconSize: 30,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SettingsPage();
                    });
              },
              color: Colors.black,
              padding: EdgeInsets.only(right: 20),
            )
          ],
        ),
        floatingActionButton: Container(
          height: 70,
          width: 150,
          child: FloatingActionButton.extended(
            tooltip: "Study",
            backgroundColor: Colors.black,
            onPressed: () => submitfunction(context),
            label: Text(
              "Study",
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.school,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {}, //TODO we need a Info Page
                  iconSize: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    "Paste What Your Text And Press Submit",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            Container(
              child: TextFormField(
                textDirection: TextDirection.rtl,
                controller: field,
                maxLines: 18,
                style: TextStyle(color: Colors.black, fontSize: 25),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            Container(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(5),
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.content_paste,
                      size: 40,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    child: Icon(
                      Icons.clear,
                      size: 40,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = false;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                    //Code that will run when [buttonIndex]
                    if (index == 0) {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) {
                        setState(() {
                          field.text = value.text.toString();
                        });
                      });
                    } else if (index == 1) {
                      field.text = '';
                    }
                  });
                },
                isSelected: isSelected,
              ),
              padding: EdgeInsets.only(bottom: 20, top: 10, left: 70),
            ),
          ],
        ));
  }
}

class StudyPage extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  var studyText = listOfSentences[0];
  int clicks = 1;
  int repeatWordsCounter = repeatWords;
  var listOfWords;

  void splitSentences(int sentenceNumber) {
    var listOfSpliters = ["...", " *** ", ",", "،"];
    for (var spliter in listOfSpliters) {
      if (theContent.trim().contains(spliter)) {
        listOfSentences = theContent
            .toString()
            .trim()
            .split(spliter)
            .join(" ")
            .trim()
            .split("  ");
      }
    }
    listOfWords = [];
    var words = listOfSentences[sentenceNumber].toString().split(" ");
    for (var word in words) {
      listOfWords.add(word);
    }
  }

  void hideWords(int sentenceNumber) {
    splitSentences(sentenceNumber);
    print("words in list : $listOfWords");
    print("words " + listOfWords.join(" ").toString());
    var hideWordNumber = Random().nextInt(listOfWords.length);
    studyText = listOfWords
        .join(" ")
        .toString()
        .replaceFirst(listOfWords[hideWordNumber], '___');

    print("replacedString : $studyText");
  }

  void studyBtnfunction() {
    var minClicks = clicks - 1;
    print(listOfSentences.length);
    setState(() {
      if (clicks > listOfSentences.length - 1) {
        clicks = 0;
        minClicks = 2;
      } else {
        if (repeatWordsCounter == 1) {
          hideWords(clicks);
          repeatWordsCounter = repeatWords;
          clicks++;
        } else {
          if (minClicks == -1) {
            minClicks = 2;
            print("minCLicks done");
          } else {
            hideWords(minClicks);
          }
          repeatWordsCounter--;
        }
      }

      print("$repeatWords : $repeatWordsCounter");
      print(clicks);
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Study",
              style: TextStyle(color: Colors.black, fontSize: 25)),
          backgroundColor: Colors.white,
          elevation: 0.5,
          toolbarHeight: toolBarHeight,
        ),
        floatingActionButton: Container(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              tooltip: "Edit",
              backgroundColor: Colors.black,
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
            )),
        body: ListView(
          children: [
            Padding(
              child: SizedBox(
                width: 20,
                height: 300,
                child: Text(
                  '$studyText',
                  style: TextStyle(fontSize: 40, height: textHeight),
                  maxLines: 5,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
              padding: EdgeInsets.all(30),
            ),
            Divider(
              color: Colors.black,
              indent: 50,
              endIndent: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 90),
                Center(
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      onPressed: () => studyBtnfunction(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Study",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      )),
                ),
                SizedBox(width: 40),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      studyText = listOfWords.join(" ").toString();
                    });
                  },
                  iconSize: 50,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 90, 50, 50),
              child: Center(
                  child: Text(
                "$repeatWordsCounter",
                style: TextStyle(fontSize: 90),
              )),
            )
          ],
        ));
  }
}
