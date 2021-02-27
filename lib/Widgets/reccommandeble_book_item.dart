import 'package:book_worm/Models/recommendable_book.dart';
import 'package:book_worm/Screens/single_book_screen.dart';
import 'package:flutter/material.dart';

class RBookItem extends StatelessWidget {
  final RecommendableBook book;

  const RBookItem({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(book.toString());
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => SingleBookScreen(book: book)));
      },
      child: ListTile(
        leading: Image.network(book.IMAGEURL),
        title: Text(
          book.TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
        subtitle: Text(
          book.GENRES,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
