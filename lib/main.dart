import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(lightTheme), child: TheMaterialApp());
  }
}

class MyLangauge with ChangeNotifier {
  bool _isEnglish = false;
  bool get langaugeSetter => _isEnglish;

  set langaugeSetter(bool newValue) {
    _isEnglish = newValue;
    notifyListeners();
  }
}

class TheMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return ChangeNotifierProvider(
      create: (context) => MyLangauge(),
      child: MaterialApp(
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/study': (context) => StudyPage(),
          '/settings': (context) => SettingsPage()
        },
      ),
    );
  }
}

//Global Variables
int repeatWords = 3;
double toolBarHeight = 70;
TextEditingController field = TextEditingController();
var theContent = '';
var listOfSentences;
double textHeight = 2;
double studyTextFontSize = 40;

//Theme Toggle Buttons and themeChanger Function
void onThemeChanged(int value, ThemeNotifier themeNotifier) {
  switch (value) {
    case 0:
      themeNotifier.setTheme(lightTheme);
      break;
    case 1:
      themeNotifier.setTheme(amberTheme);
      break;
    case 2:
      themeNotifier.setTheme(darkTheme);
      break;
  }
}

class StudyFontSize extends StatefulWidget {
  @override
  _StudyFontSizeState createState() => _StudyFontSizeState();
}

class _StudyFontSizeState extends State<StudyFontSize> {
  double newValue;

  @override
  Widget build(BuildContext context) {
    final mylangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = mylangauge._isEnglish;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
      children: [
        Text(isLangaugeEnglish ? "Font Size" : "حجم الخط",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1.color)),
        Slider(
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            activeColor: Theme.of(context).sliderTheme.activeTrackColor,
            value: studyTextFontSize,
            min: 20,
            max: 100,
            divisions: 8,
            label: "${studyTextFontSize.toInt()}",
            onChanged: (double value) {
              setState(() {
                studyTextFontSize = value;
              });
            }),
        SizedBox(child: Text("${studyTextFontSize.toInt()}"), width: 39),
      ],
    );
  }
}

class WordRepeatSlider extends StatefulWidget {
  @override
  _WordRepeatSliderState createState() => _WordRepeatSliderState();
}

class _WordRepeatSliderState extends State<WordRepeatSlider> {
  @override
  Widget build(BuildContext context) {
    final mylangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = mylangauge._isEnglish;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
      children: [
        Text(isLangaugeEnglish ? "Repeat Words" : "تكرار الكلمات",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1.color)),
        Slider(
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            activeColor: Theme.of(context).sliderTheme.activeTrackColor,
            value: repeatWords.toDouble(),
            min: 3,
            max: 10,
            divisions: 9,
            label: '$repeatWords',
            onChanged: (double value) {
              setState(() {
                repeatWords = value.toInt();
              });
            }),
        SizedBox(child: Text("$repeatWords"), width: 39)
      ],
    );
  }
}

Future infoDialog(BuildContext context, langaugeValue) {
  return showDialog(
      context: context,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 30,
                      color: Theme.of(context).textTheme.bodyText1.color),
                  SizedBox(width: 30),
                  Text(
                    langaugeValue ? "How To Use" : "كيفية الاستخدام",
                    style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ],
              ),
              Text(
                langaugeValue
                    ? "to split the sentences, add one of the next spliters : "
                    : "لتفصل الجُمل اضف إحد المفصلات التالية : ",
                textDirection:
                    langaugeValue ? TextDirection.ltr : TextDirection.rtl,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
              Table(
                border: TableBorder.all(style: BorderStyle.solid),
                children: [
                  TableRow(children: [
                    Text(
                      ",,,",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      " *** ",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      ",",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "،",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ));
}

class TextHeightSlider extends StatefulWidget {
  @override
  _TextHeightSliderState createState() => _TextHeightSliderState();
}

class _TextHeightSliderState extends State<TextHeightSlider> {
  @override
  Widget build(BuildContext context) {
    final mylangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = mylangauge._isEnglish;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
      children: [
        Text(isLangaugeEnglish ? "Text Height" : "حجم الاسطر",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1.color)),
        Slider(
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            activeColor: Theme.of(context).sliderTheme.activeTrackColor,
            value: textHeight,
            min: 2,
            max: 5,
            divisions: 4,
            label: '${textHeight.toInt()}',
            onChanged: (double value) {
              setState(() {
                textHeight = value;
              });
            }),
        SizedBox(child: Text('$textHeight'), width: 39)
      ],
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final isSelected1 = [false, false, false];
  final isSelected3 = [false, false, false];

  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    final mylangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = mylangauge._isEnglish;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: Theme.of(context).appBarTheme.iconTheme.color,
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(isLangaugeEnglish ? "Settings" : "الاعدادات",
              style: TextStyle(
                  color:
                      Theme.of(context).appBarTheme.textTheme.bodyText1.color,
                  backgroundColor: Theme.of(context).appBarTheme.color)),
          elevation: 0.5,
          toolbarHeight: 60,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(isLangaugeEnglish ? "Arabic" : "عربي",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                Switch(
                    value: mylangauge._isEnglish,
                    onChanged: (value) => mylangauge.langaugeSetter = value),
                Text(isLangaugeEnglish ? "English" : "انجليزي",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
              ],
            ),
            WordRepeatSlider(),
            StudyFontSize(),
            TextHeightSlider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection:
                  isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
              children: [
                Text(isLangaugeEnglish ? "Theme " : "   المظهر",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color)),
                ToggleButtons(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(isLangaugeEnglish ? "White" : "ابيض",
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(isLangaugeEnglish ? "Amber" : "بني",
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(isLangaugeEnglish ? "Black" : "اسود",
                          textAlign: TextAlign.center),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected1.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected1[buttonIndex] = true;
                          print(buttonIndex);
                        } else {
                          isSelected1[buttonIndex] = false;
                        }
                      }

                      onThemeChanged(index, themeNotifier);
                      print(index);
                    });
                  },
                  isSelected: isSelected1,
                ),
              ],
            )
          ],
        ));
  }
}

Future showErrorAlert(BuildContext context, bool langaugeValue) {
  return showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            child: Icon(Icons.priority_high),
            backgroundColor: Colors.red[300],
            foregroundColor: Colors.white,
          ),
          SizedBox(width: 30),
          Text(
            langaugeValue ? "Error" : "خطأ",
            style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyText1.color),
          )
        ]),
        content: Text(
            langaugeValue
                ? "No Text or Your Text is less then a sentence."
                : ".لا يوجد محتوى او انه اقل من جملة",
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).textTheme.bodyText1.color)),
      ));
}

void submitfunction(BuildContext context, langaugeValue) {
  bool isEnglishLangauge = langaugeValue;

  theContent = field.text;

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
  if (listOfSentences == null) {
    showErrorAlert(context, isEnglishLangauge);
  } else {
    Navigator.pushReplacementNamed(context, '/study');
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    final myLangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = myLangauge._isEnglish;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(isLangaugeEnglish ? "Home" : "رئيسية",
              style: TextStyle(
                  color:
                      Theme.of(context).appBarTheme.textTheme.bodyText1.color,
                  fontSize: 25)),
          backgroundColor: Theme.of(context).appBarTheme.color,
          elevation: 0.5,
          toolbarHeight: toolBarHeight,
          leading: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                infoDialog(context, isLangaugeEnglish);
              }, //TODO we need a Info Page
              iconSize: 30,
              color: Theme.of(context).appBarTheme.iconTheme.color),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                iconSize: 30,
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                color: Theme.of(context).appBarTheme.iconTheme.color,
                padding: EdgeInsets.only(right: 20))
          ],
        ),
        floatingActionButton: Container(
          height: 70,
          width: 150,
          child: FloatingActionButton.extended(
            tooltip: isLangaugeEnglish ? "Study" : "ادرس",
            backgroundColor: Theme.of(context).buttonColor,
            onPressed: () {
              if (field.text.length == 0) {
                showErrorAlert(context, isLangaugeEnglish);
              } else {
                submitfunction(context, isLangaugeEnglish);
              }
            },
            label: Text(
              isLangaugeEnglish ? "Study" : "ادرس",
              textDirection:
                  isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
              style: TextStyle(color: Theme.of(context).textTheme.button.color),
            ),
            icon: Icon(
              Icons.school,
              color: Theme.of(context).textTheme.button.color,
              size: 30,
              textDirection:
                  isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
            ),
          ),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    isLangaugeEnglish
                        ? "Paste What Your Text And Press Study"
                        : "الصق ما تريد حفظه واضغط زر ادرس",
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
              ],
            ),
            Container(
              child: TextFormField(
                autofocus: false,
                textDirection:
                    isLangaugeEnglish ? TextDirection.ltr : TextDirection.rtl,
                controller: field,
                maxLines: 16,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 25),
                cursorColor: Theme.of(context).textSelectionColor,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).focusColor,
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hoverColor: Theme.of(context).hoverColor,
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
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
  List listOfWords;

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
      if (word != "") {
        listOfWords.add(word);
      }
    }
  }

  void hideWords(int sentenceNumber) {
    splitSentences(sentenceNumber);
    print("words in list : $listOfWords");
    print("words " + listOfWords.join(" ").toString());
    var hideWordNumber = Random().nextInt(listOfWords.length);
    studyText = listOfWords.join(" ").toString().replaceFirst(
        listOfWords[hideWordNumber] == "***"
            ? listOfWords[hideWordNumber - 1]
            : listOfWords[hideWordNumber],
        '___');

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
  }

  @override
  Widget build(BuildContext context) {
    final mylangauge = Provider.of<MyLangauge>(context);
    bool isLangaugeEnglish = mylangauge._isEnglish;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(isLangaugeEnglish ? "Study" : "ادرس",
              style: TextStyle(
                  color:
                      Theme.of(context).appBarTheme.textTheme.bodyText1.color,
                  fontSize: 25)),
          backgroundColor: Theme.of(context).appBarTheme.color,
          elevation: 0.5,
          toolbarHeight: toolBarHeight,
        ),
        floatingActionButton: Container(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              tooltip: isLangaugeEnglish ? "Edit" : "تعديل",
              backgroundColor: Theme.of(context).buttonColor,
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: Icon(
                Icons.edit,
                color: Theme.of(context).textTheme.button.color,
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
                  style: TextStyle(
                      fontSize: studyTextFontSize,
                      height: textHeight,
                      fontFamily: "Amiri",
                      color: Theme.of(context).textTheme.bodyText1.color),
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
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        studyBtnfunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isLangaugeEnglish ? "Study" : "ادرس",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).textTheme.button.color),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      )),
                ),
                SizedBox(width: 40),
                IconButton(
                  icon: Icon(Icons.visibility),
                  color: Theme.of(context).textTheme.bodyText1.color,
                  splashColor: Theme.of(context).buttonColor,
                  tooltip: isLangaugeEnglish
                      ? "Show the hidden Word"
                      : "اظهار الكلمة المخفية",
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
                style: TextStyle(
                    fontSize: 90,
                    color: Theme.of(context).textTheme.bodyText1.color),
              )),
            )
          ],
        ));
  }
}
