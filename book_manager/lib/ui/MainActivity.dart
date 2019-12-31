import 'package:book_manager/model/Book.dart';
import 'package:book_manager/model/ThemeProperties.dart';
import 'package:book_manager/services/RESTServices.dart';
import 'package:flutter/material.dart';

class MainActivity extends StatefulWidget {
  final String title;
  final ThemeProperties themeProperties;

  MainActivity({Key key, this.title, this.themeProperties}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Book> books = new List();
  RESTServices restServices = RESTServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.book,
                color: widget
                    .themeProperties.colorMap["iconLight"]),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(widget.title))
          ],
        ),
        bottomOpacity: 0.5,
        elevation: 10),body:
      RefreshIndicator(
        onRefresh: () {
          return restServices.getBooks().then((value) {
            books = value;
            setState(() {});
          });
        },
        backgroundColor: widget.themeProperties.colorMap["appButtons"],
        color: widget.themeProperties.colorMap["iconLight"],
        child: FutureBuilder(
          future: restServices.getBooks().then((value) {
            books = value;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Scaffold(
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 200,
                          ),
                          RawMaterialButton(
                            child: Icon(
                              Icons.refresh,
                              color:
                                  widget.themeProperties.colorMap["iconLight"],
                            ),
                            onPressed: () {
                              setState(() {});
                              return;
                            },
                            shape: new CircleBorder(),
                            fillColor:
                                widget.themeProperties.colorMap["appButtons"],
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                "Something went wrong, press the button to reload.",
                                style:
                                    widget.themeProperties.textStyleMap["text"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              }
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemCount: books.length,
                        itemBuilder: (BuildContext ctxt, int index) =>
                            _generateBookTiles(ctxt, index),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(color: Colors.blueGrey),
                        physics: new BouncingScrollPhysics(),
                      ),
                    ),
                    Container(
                      height: 25,
                    )
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 5,
                  elevation: 10,
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                        "Select one book to see its information.",
                        style: widget.themeProperties.textStyleMap["bottomBar"],
                      )),
                      Container(
                        width: 70,
                        height: 30,
                      )
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: _addBook,
                  tooltip: 'Add a new book',
                  child: Icon(
                    Icons.add,
                    color: widget.themeProperties.colorMap["iconLight"],
                  ),
                ),
              );
            } else {
              return Scaffold(
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
                          "Searching for books",
                          style: widget.themeProperties.textStyleMap["text"],
                        )
                      ],
                    ),
                  ));
            }
          },
        )));
  }

  MaterialButton _generateBookTiles(BuildContext ctxt, int index) {
    Book book = books[index];

    return new MaterialButton(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            book.imageURL,
                          )),
                      color: Colors.white),
                ),
                height: 30,
                width: 30,
              ),
              Container(
                width: 20,
              ),
              SizedBox(
                width: 205,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(book.name,
                        style: widget.themeProperties.textStyleMap["text"]),
                    Text("By " + book.author,
                        style: widget.themeProperties.textStyleMap["text2"])
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: widget.themeProperties.colorMap["iconDark"],
                  tooltip: 'Show information',
                  iconSize: 35)
            ]),
        onPressed: () {
          _showBook(book.id);
        });
  }

  void _showBook(int id) {
    Map<String, Object> args = new Map();
    args["id"] = id;

    Navigator.of(context).pushNamed('/book', arguments: args);
  }

  void _addBook() {
    Map<String, Object> args = new Map();
    args["isSaved"] = false;
    args["book"] = new Book(null, -1, "", "", "", "");
    args["title"] = "New Book";

    Navigator.of(context).pushNamed('/form', arguments: args);
  }
}
