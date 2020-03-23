import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProperties {

  Map<String, Color> colorMap = new Map();
  Map<String, TextStyle> textStyleMap = new Map();
  Map<String, IconThemeData> iconThemeMap = new Map();

  ThemeProperties() {
    createColors();
    createTextStyles();
    createIconThemes();
  }

  void createColors() {
    colorMap["appAndBottomBar"] = new Color.fromARGB(255, 0, 89, 34);
    colorMap["appButtons"] = new Color.fromARGB(255, 0, 150, 34);
    colorMap["appBackground"] = new Color.fromARGB(255, 235, 255, 240);
    colorMap["text"] = Colors.black;
    colorMap["textTitles"] = new Color.fromARGB(255, 230, 238, 233);
    colorMap["textCaption"] = new Color.fromARGB(255, 82, 104, 82);
    colorMap["iconDark"] = new Color.fromARGB(255, 65, 107, 75);
    colorMap["iconLight"] = new Color.fromARGB(255, 211, 232, 215);
  }

  void createTextStyles() {
    List<Shadow> shadows = new List();
    shadows.add(new Shadow(
        color: Colors.grey,
        blurRadius: 5,
        offset: Offset.fromDirection(1, 3)));

    textStyleMap["titleApp"] = new TextStyle(
        fontSize: 25,
        color: colorMap["textTitles"],
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        shadows: shadows);
    textStyleMap["bottomBar"] = new TextStyle(
        fontSize: 15,
        color: colorMap["textTitles"],
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        shadows: shadows);
    textStyleMap["button"] = new TextStyle(
        fontSize: 10,
        color: colorMap["textTitles"],
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        shadows: shadows);
    textStyleMap["text"] = new TextStyle(
        fontSize: 20,
        color: colorMap["text"],
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        shadows: shadows);
    textStyleMap["text2"] = new TextStyle(
        fontSize: 15,
        color: colorMap["textCaption"],
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        shadows: shadows);
  }

  void createIconThemes() {
    iconThemeMap["appBar"] =
    new IconThemeData(color: colorMap["iconDark"], size: 40);
    iconThemeMap["button"] =
    new IconThemeData(color: colorMap["iconLight"], size: 30);
    iconThemeMap["body"] =
    new IconThemeData(color: colorMap["iconDark"], size: 30);
  }
}