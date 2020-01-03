import 'package:book_manager/model/ThemeProperties.dart';
import 'package:book_manager/ui/BookActivity.dart';
import 'package:book_manager/ui/FormActivity.dart';
import 'package:book_manager/ui/MainActivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeProperties themeProperties = new ThemeProperties();

    TextTheme textTheme = new TextTheme(
        title: themeProperties.textStyleMap["titleApp"],
        body1: themeProperties.textStyleMap["text"],
        headline: themeProperties.textStyleMap["text"],
        subhead: themeProperties.textStyleMap["text"],
        caption: themeProperties.textStyleMap["text2"],
        subtitle: themeProperties.textStyleMap["text2"],
        button: themeProperties.textStyleMap["button"]);

    AppBarTheme appBarTheme = new AppBarTheme(
        elevation: 10,
        actionsIconTheme: themeProperties.iconThemeMap["button"],
        color: themeProperties.colorMap["appAndBottomBar"],
        textTheme: textTheme,
        iconTheme: themeProperties.iconThemeMap["appBar"]);

    BottomAppBarTheme bottomAppBarTheme = new BottomAppBarTheme(
        elevation: 10, color: themeProperties.colorMap["appAndBottomBar"]);

    ButtonThemeData buttonThemeData = new ButtonThemeData(
        textTheme: ButtonTextTheme.normal, buttonColor: themeProperties.colorMap["appButtons"]);

    FloatingActionButtonThemeData floatingActionButtonThemeData =
        new FloatingActionButtonThemeData(
            backgroundColor: themeProperties.colorMap["appButtons"], elevation: 10);

    return MaterialApp(
      title: 'Flutter example',
      theme: ThemeData.light().copyWith(
          primaryColor: themeProperties.colorMap["appAndBottomBar"],
          accentColor: themeProperties.colorMap["appBackground"],
          accentColorBrightness: Brightness.light,
          buttonColor: themeProperties.colorMap["appButtons"],
          floatingActionButtonTheme: floatingActionButtonThemeData,
          backgroundColor: themeProperties.colorMap["appBackground"],
          scaffoldBackgroundColor: themeProperties.colorMap["appBackground"],
          appBarTheme: appBarTheme,
          bottomAppBarTheme: bottomAppBarTheme,
          textTheme: textTheme,
          buttonTheme: buttonThemeData,
          iconTheme: themeProperties.iconThemeMap["body"]
      ),
      routes: {
        '/': (context) => MainActivity(title: 'Book Manager', themeProperties: themeProperties),
        '/book': (context) => BookActivity(themeProperties: themeProperties),
        '/form': (context) => FormActivity(themeProperties: themeProperties),
      },
    );
  }


}
