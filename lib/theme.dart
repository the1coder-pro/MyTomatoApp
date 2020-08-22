import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[200],
    indicatorColor: Color(0xFF8d8d8d),
    textSelectionColor: Color(0xFF8d8d8d),
    textSelectionHandleColor: Color(0xFF8d8d8d),
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey[800])),
    primaryColor: Colors.grey[900],
    dialogTheme: DialogTheme(
        backgroundColor: Color(0xFFe0e0e0),
        contentTextStyle: TextStyle(color: Colors.grey[900])),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[800],
        contentTextStyle: TextStyle(color: Colors.grey[300])),
    appBarTheme: AppBarTheme(
        color: Colors.grey[400],
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey[900])),
        iconTheme: IconThemeData(color: Colors.grey[900])),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.grey[900]),
        bodyText2: TextStyle(fontSize: 20),
        button: TextStyle(color: Colors.grey[300])),
    buttonColor: Colors.grey[900],
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        borderColor: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
        selectedBorderColor: Colors.grey[800],
        selectedColor: Colors.grey[800],
        fillColor: Colors.grey[400]),
    sliderTheme: SliderThemeData(
        activeTrackColor: Colors.grey[800],
        inactiveTrackColor: Colors.grey,
        valueIndicatorTextStyle: TextStyle(color: Colors.grey[50])));

final amberTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFffffe4),
    indicatorColor: Color(0xFF341c13),
    textSelectionColor: Color(0xFFffe0b2),
    textSelectionHandleColor: Color(0xFFffe0b2),
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFF341c13))),
    primaryColor: Color(0xFFffe0b2),
    dialogTheme: DialogTheme(
        backgroundColor: Color(0xFFDCC1A7),
        contentTextStyle: TextStyle(color: Color(0xFF341c13))),
    tabBarTheme: TabBarTheme(labelColor: Color(0xFFDCC1A7)),
    appBarTheme: AppBarTheme(
        color: Color(0xFF5f4339),
        textTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFFffffe4))),
        iconTheme: IconThemeData(color: Color(0xFFffffe4))),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Color(0xFF341c13)),
        bodyText2: TextStyle(fontSize: 20),
        button: TextStyle(color: Color(0xFFffffe4))),
    snackBarTheme: SnackBarThemeData(backgroundColor: Color(0xFFffe0b2)),
    buttonColor: Color(0xFF5f4339),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xFFDCC1A7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        borderRadius: BorderRadius.circular(10),
        borderColor: Color(0xFF8d6e63),
        color: Color(0xFF341c13),
        selectedBorderColor: Color(0xFF8d6e63),
        selectedColor: Color(0xFFffffe4),
        fillColor: Color(0xFF8d6e63)),
    sliderTheme: SliderThemeData(
        activeTrackColor: Color(0xFF341c13),
        inactiveTrackColor: Color(0xFFffe0b2),
        valueIndicatorTextStyle: TextStyle(color: Colors.grey[50])));

final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF000000),
    indicatorColor: Colors.grey[800],
    textSelectionColor: Colors.grey[300],
    textSelectionHandleColor: Colors.grey[300],
    primaryColor: Color(0xFFe0e0e0),
    dialogTheme: DialogTheme(
        backgroundColor: Color(0xFF000000),
        contentTextStyle: TextStyle(color: Color(0xFFe0e0e0))),
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFFe0e0e0))),
    appBarTheme: AppBarTheme(
        color: Color(0xFF484848),
        textTheme: TextTheme(bodyText1: TextStyle(color: Color(0xFFe0e0e0))),
        iconTheme: IconThemeData(color: Color(0xFFe0e0e0))),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Color(0xFFe0e0e0)),
        bodyText2: TextStyle(fontSize: 20),
        button: TextStyle(color: Color(0xFFe0e0e0))),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xFF212121),
        contentTextStyle: TextStyle(color: Color(0xFFe0e0e0))),
    buttonColor: Color(0xFF212121),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        borderColor: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
        selectedBorderColor: Colors.grey[300],
        selectedColor: Colors.grey[300],
        fillColor: Colors.grey[700]),
    sliderTheme: SliderThemeData(
        activeTrackColor: Colors.grey[300],
        inactiveTrackColor: Colors.grey[700],
        valueIndicatorTextStyle: TextStyle(color: Colors.grey[50])));

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
