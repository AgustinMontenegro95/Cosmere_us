import 'package:cosmere_us/components/book_list.dart';
import 'package:cosmere_us/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRepository {
  Future<List<Book>> getBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Encode and store data in SharedPreferences
    // Fetch and decode data
    final String? bookString = prefs.getString('book');
    if (bookString != null) {
      return book = Book.decode(bookString);
    } else {
      final String encodedData = Book.encode(book);
      prefs.setString('book', encodedData);
      return book;
    }
  }

  Future<void> statusBook(status, index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bookString = prefs.getString('book');
    book = Book.decode(bookString!);
    book[index].status = status;
    final String encodedData = Book.encode(book);
    prefs.setString('book', encodedData);
  }

  Future<void> rateBook(rate, index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bookString = prefs.getString('book');
    book = Book.decode(bookString!);
    book[index].rate = rate;
    final String encodedData = Book.encode(book);
    prefs.setString('book', encodedData);
  }
}
