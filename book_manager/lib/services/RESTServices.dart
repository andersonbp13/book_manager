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
/*

    books.add(new Book(1, 123, "Libro 1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "Autor 1", "https://png.pngtree.com/element_pic/16/10/29/8a6fa9d903aa625bd76b914b91301423.jpg", "comedia"));
    books.add(new Book(2, 123, "Libro 2", "Autor 2", "https://www.stickpng.com/assets/images/580b585b2edbce24c47b276b.png", "comedia"));
    books.add(new Book(3, 123, "Libro 3", "Autor 3", "https://png.pngtree.com/png-clipart/20190906/original/pngtree-green-modern-book-illustration-png-image_4581211.jpg", "comedia"));
    books.add(new Book(4, 123, "Libro 4", "Autor 4", "https://i0.pngocean.com/files/328/350/448/book-publishing-e-readers-taixuanjing-literature-book.jpg", "comedia"));
    books.add(new Book(5, 123, "Libro 5", "Autor 5", "https://www.pinclipart.com/picdir/middle/209-2098983_libro-abierto-vector-clipart-book-clip-art-open.png", "comedia"));
    books.add(new Book(6, 123, "Libro 6", "Autor 6", "https://image.flaticon.com/icons/png/512/85/85523.png", "comedia"));
    books.add(new Book(7, 123, "Libro 7", "Autor 7", "https://www.pinclipart.com/picdir/middle/33-336480_libro-vector-clipart-black-and-white-library-de.png", "comedia"));
    books.add(new Book(8, 123, "Libro 8", "Autor 8", "https://i0.pngocean.com/files/777/743/707/book-free-content-clip-art-clip-art-open-book-pages-png.jpg", "comedia"));
    books.add(new Book(9, 123, "Libro 9", "Autor 9", "https://images.vexels.com/media/users/3/153719/isolated/preview/3a310ffc1a26ffccf33f9cc485984d97-icono-de-tapa-dura-libro-by-vexels.png", "comedia"));
    books.add(new Book(10, 123, "Libro 10", "Autor 10", "http://ignius.com.mx/wp-content/uploads/2019/05/libro-preguntas-ventas-oro.png", "comedia"));
*/
  }

  Future<Book> getBook(int id) async {
    http.Response response = await http.get("http://"+IP+":"+PORT+"/books"+id.toString());
    //print(json.decode(response.body));
    return Book.fromJson(json.decode(response.body));
  }

  Future<void> saveBook(Book book) async {
    print(book.toJson());
    await http.post(("http://"+IP+":"+PORT+"/books"),body: json.encode(book), headers: {
      "Content-type" : "application/json"
    });
  }

  Future<void> updateBook(Book book) async {
    await http.put(("http://"+IP+":"+PORT+"/books"+book.id.toString()),body: json.encode(book), headers: {
      "Content-type" : "application/json"
    });
  }

  Future<void> deleteBook(int id) async{
    await http.delete(("http://"+IP+":"+PORT+"/books"+id.toString()));
  }
}
