// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:book_manager/model/ThemeProperties.dart';
import 'package:book_manager/ui/FormActivity.dart';
import 'package:book_manager/ui/MainActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';


import 'package:book_manager/main.dart';

void main() {
  testWidgets('book manager test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(MaterialApp(home: MainActivity(
        title: "hola", themeProperties: new ThemeProperties())));

    //expect(find.text('Searching for books'), findsOneWidget);
    //await tester.pump();
    expect(find.text('Select one book to see its information.'), findsOneWidget);


   /* await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await tester.tap(find.byWidget(MaterialButton()));
    await tester.pump();*/

    //expect(textfield, findsOneWidget);


   /* await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byWidget(MaterialButton()));
    await tester.pump();

    expect(find.text('Book name can not be empty.'), findsOneWidget);


    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);*/
  });
}
