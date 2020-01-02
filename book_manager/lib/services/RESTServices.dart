import 'dart:convert';

import 'package:book_manager/model/Book.dart';
import 'package:http/http.dart' as http;

class RESTServices {
  static final RESTServices _instance = RESTServices._constructor();
  static final String IP = "192.168.1.64";
  static final String PORT = "8080";

  factory RESTServices(){
    return _instance;
  }

  RESTServices._constructor();

  Future<List<Book>> getBooks() async {
    List<Book> books = new List();

    http.Response response = await http.get("http://"+IP+":"+PORT+"/books");
    List jsons = json.decode(response.body);

    for(int i = 0; i< jsons.length;i++) {
      books.add(Book.fromJson(jsons[i]));
    }

    return books;
  }

  Future<Book> getBook(int id) async {
    http.Response response = await http.get("http://"+IP+":"+PORT+"/books/"+id.toString());
    return Book.fromJson(json.decode(response.body));
  }

  Future<void> saveBook(Book book) async {
    print(book.toJson());
    await http.post(("http://"+IP+":"+PORT+"/books"),body: json.encode(book), headers: {
      "Content-type" : "application/json"
    });
  }

  Future<void> updateBook(Book book) async {
    await http.put(("http://"+IP+":"+PORT+"/books/"+book.id.toString()),body: json.encode(book), headers: {
      "Content-type" : "application/json"
    });
  }

  Future<void> deleteBook(int id) async{
    await http.delete(("http://"+IP+":"+PORT+"/books/"+id.toString()));
  }
}
