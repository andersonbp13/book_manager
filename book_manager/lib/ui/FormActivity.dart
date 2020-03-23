import 'package:book_manager/model/Book.dart';
import 'package:book_manager/model/ThemeProperties.dart';
import 'package:book_manager/services/RESTServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormActivity extends StatefulWidget {
  final ThemeProperties themeProperties;

  FormActivity({Key key, this.themeProperties}) : super(key: key);

  @override
  _FormActivityState createState() => _FormActivityState();
}

class _FormActivityState extends State<FormActivity> {
  Map<String, Object> args;
  RESTServices restServices = RESTServices();

  bool isSaved;
  Book book;
  String title;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    isSaved = args["isSaved"];
    book = args["book"];
    title = args["title"];

    String priceString = _takePriceString();

    return WillPopScope(
        onWillPop: _goBack,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              //onPressed: _goBack,
              color: widget.themeProperties.colorMap["iconLight"],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Text(title),
                  width: 170,
                ),
              ],
            ),
            bottomOpacity: 0.5,
            elevation: 10,
          ),
          body: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Book name:",
                                hintText: "Enter the book name",
                                hintStyle: widget
                                    .themeProperties.textStyleMap["text2"]),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Book name can not be empty.";
                              }
                              book.name = value;
                              return null;
                            },
                            initialValue: book.name,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Book author:",
                                hintText: "Enter the book author.",
                                hintStyle: widget
                                    .themeProperties.textStyleMap["text2"]),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Book author can not be empty.";
                              }
                              book.author = value;
                              return null;
                            },
                            initialValue: book.author,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Book genre:",
                                hintText: "Enter the book genre.",
                                hintStyle: widget
                                    .themeProperties.textStyleMap["text2"]),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Book genre can not be empty.";
                              }
                              book.genre = value;
                              return null;
                            },
                            initialValue: book.genre,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Book price:",
                                hintText: "Enter the book price",
                                hintStyle: widget
                                    .themeProperties.textStyleMap["text2"]),
                            validator: (value) {
                              if (value.isEmpty || _checkPrices(value) == false) {
                                return "Book price can not be empty and must be a number.";
                              }
                              book.price = double.parse(value);
                              return null;
                            },
                            initialValue: priceString,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Book image URL:",
                                hintText: "Enter the book image URL.",
                                hintStyle: widget
                                    .themeProperties.textStyleMap["text2"]),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Book image URL can not be empty.";
                              }
                              book.imageURL = value;
                              return null;
                            },
                            initialValue: book.imageURL,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _saveBook();
                              }
                            },
                            child: Text("Send",
                                style: widget
                                    .themeProperties.textStyleMap["button"],
                                textScaleFactor: 2),
                          ),
                        ),
                        Container(
                          height: 20,
                        )
                      ]),
                    )),
                  ])),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            elevation: 10,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  "Fill in all the form fields.",
                  style: widget.themeProperties.textStyleMap["bottomBar"],
                )),
                Container(
                  width: 160,
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }

  bool _checkPrices(String price) {
    try{
      double.parse(price);
      return true;
    }catch(e){
      return false;
    }
  }

  String _takePriceString() {
    if (book.price == -1) {
      return "";
    }
    return book.price.toString();
  }

  Future<bool> _goBack() {
    Navigator.of(context).pop();
  }

  void _saveBook() {
    if (isSaved == true) {
      restServices.updateBook(book).then((value) {
        Navigator.of(context).pop();
      });
    } else {
      restServices.saveBook(book).then((value) {
        Navigator.of(context).pop();
      });
    }
  }
}
