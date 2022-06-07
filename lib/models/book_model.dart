import 'dart:convert';

class Book {
  Book({
    this.title,
    this.description,
    this.rate,
    this.status,
    this.image,
    this.pending,
  });

  String? title;
  String? description;
  String? rate;
  bool? status;
  String? image;
  bool? pending;

  factory Book.fromJson(Map<dynamic, dynamic> json) => Book(
        title: json["title"],
        description: json["description"],
        rate: json["rate"],
        status: json["status"],
        image: json["image"],
        pending: json["pending"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "rate": rate,
        "status": status,
        "image": image,
        "pending": pending,
      };

  static Map<String, dynamic> toMap(Book producto) => {
        "title": producto.title,
        "description": producto.description,
        "rate": producto.rate,
        "status": producto.status,
        "image": producto.image,
        "pending": producto.pending,
      };

  static String encode(List<Book> productos) => json.encode(
        productos
            .map<Map<String, dynamic>>((producto) => Book.toMap(producto))
            .toList(),
      );

  static List<Book> decode(String producto) =>
      (json.decode(producto) as List<dynamic>)
          .map<Book>((item) => Book.fromJson(item))
          .toList();
}
