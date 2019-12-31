import 'dart:async';

import 'package:book_manager/model/Book.dart';
import 'package:book_manager/model/ThemeProperties.dart';
import 'package:book_manager/services/RESTServices.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookActivity extends StatefulWidget {
  final ThemeProperties themeProperties;

  BookActivity({Key key, this.themeProperties}) : super(key: key);

  @override
  _BookActivityState createState() => _BookActivityState();
}

class _BookActivityState extends State<BookActivity> {
  Map<String, Object> args;
  RESTServices restServices = RESTServices();

  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(6.2786293, -75.540737), zoom: 13);
  Completer<GoogleMapController> _controller = Completer();

  int id;
  Book book;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    id = args["id"];

    return WillPopScope(
      onWillPop: _goBack,
      child: FutureBuilder(
        future: restServices.getBook(id).then((value) {
          book = value;
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                  appBar: AppBar(
                    leading: BackButton(
                      onPressed: _goBack,
                      color: widget.themeProperties.colorMap["iconLight"],
                    ),
                    bottomOpacity: 0.5,
                    elevation: 10,
                  ),
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200,
                        ),
                        RawMaterialButton(
                          child: Icon(Icons.refresh, color: widget.themeProperties.colorMap["iconLight"] ,),
                          onPressed: () {
                            setState(() {});
                            return;
                          }, shape: new CircleBorder(),fillColor: widget.themeProperties.colorMap["appButtons"],
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              "Something went wrong, press the button to reload.",
                              style: widget.themeProperties.textStyleMap["text"],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            }
            return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: _goBack,
                    color: widget.themeProperties.colorMap["iconLight"],
                  ),
                  //automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Text(book.name),
                        width: 170,
                      ),
                      IconButton(
                        icon: new Icon(Icons.edit),
                        onPressed: () {
                          _editBook();
                        },
                        color: widget.themeProperties.colorMap["iconLight"],
                        tooltip: "Edit book information.",
                      ),
                      IconButton(
                          icon: new Icon(Icons.delete),
                          onPressed: _deleteBook,
                          color: widget.themeProperties.colorMap["iconLight"],
                          tooltip: "Delete book.")
                    ],
                  ),
                  bottomOpacity: 0.5,
                  elevation: 10,
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Container(
                                child: SizedBox(
                                  child: Image.network(book.imageURL,
                                      fit: BoxFit.contain),
                                  width: 350,
                                  height: 320,
                                ),
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                child: Text(
                                  "Name: " + book.name,
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                child: Text(
                                  "Author: " + book.author,
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                child: Text(
                                  "Genre: " + book.genre,
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                child: Text(
                                  "Price: " + book.price.toString() + "\$",
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Text(
                                  "Description: " +
                                      'here is a describing text of the book:\n\n '
                                          'Lorem ipsum dolor sit amet consectetur '
                                          'adipiscing elit nisi, luctus blandit cum eget o'
                                          'dio proin aenean, cras rhoncus class nulla elementum conubia dapibus. '
                                          'Vulputate sapien aliquam ultrices diam ligula parturient lobortis, '
                                          'enim nulla primis vehicula litora blandit orci pellentesque, '
                                          'odio consequat sociis dictumst ornare nibh. ',
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Text(
                                  "Location: ",
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    if (!_controller.isCompleted) {
                                      _controller.complete(controller);
                                    }
                                  },
                                  initialCameraPosition: _initialPosition,
                                ),
                                width: 340,
                                height: 320,
                              ),
                              Container(
                                height: 20,
                              )
                            ]),
                          ),
                        ),
                      ),
                    ]),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {});
                    return;
                  },
                  tooltip: 'Add a new book',
                  child: Icon(
                    Icons.refresh,
                    color: widget.themeProperties.colorMap["iconLight"],
                  ),
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: _goBack,
                    color: widget.themeProperties.colorMap["iconLight"],
                  ),
                  bottomOpacity: 0.5,
                  elevation: 10,
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                      ),
                      CircularProgressIndicator(
                          backgroundColor: widget
                              .themeProperties.colorMap["appAndBottomBar"]),
                      Text(
                        "Loading book information.",
                        style: widget.themeProperties.textStyleMap["text"],
                      )
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }

  Future<bool> _goBack() {
    Navigator.of(context).pop();
  }

  void _editBook() {
    Map<String, Object> args = new Map();
    args["isSaved"] = true;
    args["book"] = book;
    args["title"] = "Edit Book";

    Navigator.of(context).pushNamed('/form', arguments: args);
  }

  void _deleteBook() {
    restServices.deleteBook(book.id).then((value) {
      Navigator.of(context).pop();
    });
  }
}
