import 'dart:convert';

import 'package:book_worm/Models/recommendable_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Book {
  final String id;
  final String name;
  final String category;

  Book({
    this.id,
    this.name,
    this.category,
    ValueKey<String> key,
  });
}

class Books with ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books {
    return [..._books];
  }

  List<RecommendableBook> _recommendedBooks = [];
  List<RecommendableBook> get recommendedBooks {
    return [..._recommendedBooks];
  }

  List<RecommendableBook> _recommendableBooks = [];
  List<RecommendableBook> get recommendableBooks {
    return [..._recommendableBooks];
  }

  List<RecommendableBook> _sameTypeBooks = [];
  List<RecommendableBook> get sameTypeBooks {
    return [..._sameTypeBooks];
  }

  Book findById(String id) {
    return _books.firstWhere((prod) => prod.id == id);
  }

//  Future<void> addBook(Book book) async {
//    const url = 'https://real-bookworm.firebaseio.com/Books.json';
//    try {
//      final response = await http.post(
//        url,
//        body: json.encode(
//          {
//            'name': book.name,
//            'category': book.category,
//          },
//        ),
//      );
//      print(json.decode(response.body));
//      if (response.statusCode >= 400) {
//        print('add book ${response.statusCode}');
//      }
//      final newBook = Book(
//        id: json.decode(response.body)['name'],
//        name: book.name,
//        category: book.category,
//      );
//      _books.add(newBook);
//      notifyListeners(); //update the listeners
//    } catch (error) {
//      print(error);
//      throw error;
//    }
//  }

  Future<void> addBook(Book book) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('books')
        .add(
      {
        'category': book.category,
        'name': book.name,
      },
    );
  }

  Future<void> fillBooks() async {
    final user = FirebaseAuth.instance.currentUser;
    final docs = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('books')
        .get();
    List<Book> _temp = [];

    docs.docChanges.forEach((element) {
      print(element.type);
      print(element.doc.toString());
      _temp.add(Book());
    });
  }

//  Future<void> updateBook(String id, Book newBook) async {
//    final prodIndex = _books.indexWhere((prod) => prod.id == id);
//    if (prodIndex >= 0) {
//      final url = 'https://shopapp-bd925.firebaseio.com/books/$id.json';
//      http.patch(
//        url,
//        body: json.encode(
//          {
//            'name': newBook.name,
//            'id': id,
//            'category': newBook.category,
//          },
//        ),
//      );
//      _books[prodIndex] = newBook;
//      notifyListeners();
//    } else {
//      print('...');
//    }
//  }
//
//  Future<void> deleteBook(String id) async {
//    final url = 'https://shopapp-bd925.firebaseio.com/books/$id.json';
//    final existingProductIndex = _books.indexWhere((book) => book.id == id);
//    var existingProduct = _books[existingProductIndex];
//    _books.removeAt(existingProductIndex);
//    final response = await http.delete(url);
//
//    if (response.statusCode >= 400) {
//      _books.insert(existingProductIndex, existingProduct);
//      notifyListeners();
////      throw HttpException('Could not Delete Product');
//    }
//    existingProduct = null;
//    notifyListeners();
//  }
//
//  Future<void> fetchAndSetBooks() async {
//    const url = 'https://real-bookworm.firebaseio.com/Books.json';
//    final response = await http.get(url);
//    try {
//      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      final List<Book> loadedBooks = [];
//      extractedData.forEach(
//        (bookId, bookData) {
//          loadedBooks.add(
//            Book(
//              name: bookData['name'],
//              category: bookData['category'],
//              id: bookId,
//            ),
//          );
//        },
//      );
//      _books = loadedBooks;
//      notifyListeners();
//    } catch (error) {
//      print(error);
//    }
//  }

  RecommendableBook findByIdR(String id) {
    return _recommendableBooks.firstWhere((prod) => prod.Id == id);
  }

  bool isExistInRecommendedBooks(
      List<RecommendableBook> myList, RecommendableBook book) {
    bool flag = false;
    for (int i = 0; i < _recommendedBooks.length; i++) {
      if (myList[i].TITLE.toUpperCase() == book.TITLE.toUpperCase()) {
        flag = true;
        print('exist');
      }
    }
    return flag;
  }

  void recommendBooks() {
    List<RecommendableBook> books = [];
    for (var j = 0; j < _books.length; j++) {
      var category = _books[j].category;
      print(category.toUpperCase());
      _recommendableBooks.shuffle();
      RecommendableBook book;
      for (int i = 0; i < _recommendableBooks.length; i++) {
        book = _recommendableBooks[i];
        if ((category.toUpperCase() ==
            _recommendableBooks[i].GENRES.toUpperCase()))
        //  && (!isExistInRecommendedBooks(books, book) || !isExist(book)))
        {
          books.add(book);
          break;
        }
      }
    }
    _recommendedBooks = books;
  }

  bool isExist(RecommendableBook book) {
    bool flag = false;
    for (int i = 0; i < _recommendableBooks.length; i++) {
      if (_recommendableBooks[i].isEqual(book)) {
        flag = true;
        print('exist');
      }
    }
    return flag;
  }

  Future<List<RecommendableBook>> getRecommendableBooks(String endpoint) async {
    var url =
        'https://bookworm-database-default-rtdb.firebaseio.com/Part$endpoint.json';
    final List<RecommendableBook> loadedBooks = List<RecommendableBook>();
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach(
        (bookId, bookData) {
          final book = RecommendableBook.fromJson(bookId, bookData);
          loadedBooks.add(
            book,
          );
        },
      );
//      _recommendableBooks = _recommendableBooks + loadedBooks;
//      _recommendableBooks
//          .sort((a, b) => int.parse(a.Id).compareTo(int.parse(b.Id)));
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return loadedBooks;
  }

  Future<void> getAllRecommendableBooks() async {
    final List<RecommendableBook> books3 = await getRecommendableBooks('3');
    final List<RecommendableBook> books4 = await getRecommendableBooks('4');
    final List<RecommendableBook> books5 = await getRecommendableBooks('5');
    final List<RecommendableBook> books6 = await getRecommendableBooks('6');
    final List<RecommendableBook> books7 = await getRecommendableBooks('7');
    final List<RecommendableBook> books8 = await getRecommendableBooks('8');
    final List<RecommendableBook> books9 = await getRecommendableBooks('9');
    final List<RecommendableBook> books10 = await getRecommendableBooks('10');

    _recommendableBooks =
        books3 + books4 + books5 + books6 + books7 + books8 + books9 + books10;
    notifyListeners();
  }
}
