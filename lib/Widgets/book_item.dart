import 'package:book_worm/Provider/books.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
//      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: CircleAvatar(
        child: Text(
          book.name[0].toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      title: Text(
        book.name.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        book.category.toUpperCase(),
      ),
    );
  }
}
