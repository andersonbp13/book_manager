import 'dart:core';

class Book {
  int id;
  double price;
  String name;
  String author;
  String imageURL;
  String genre;

  Book(this.id, this.price, this.name, this.author, this.imageURL, this.genre);

  String toString() {
    return "Book{" +
        "id=" +
        id.toString() +
        ", price=" +
        price.toString() +
        ", name='" +
        name +
        '\'' +
        ", author='" +
        author +
        '\'' +
        ", image='" +
        imageURL +
        '\'' +
        ", genre='" +
        genre +
        '\'' +
        '}';
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(json["id"], json["price"], json["name"], json["author"],
        json["imageURL"], json["genre"]);
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'price' : price,
    'name' : name,
    'author' : author,
    'imageURL' : imageURL,
    'genre' : genre,
  };
}
