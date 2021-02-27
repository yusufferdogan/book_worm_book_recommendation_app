import 'dart:ui';

import 'package:book_worm/Models/recommendable_book.dart';
import 'package:flutter/material.dart';

class SingleBookScreen extends StatelessWidget {
  final RecommendableBook book;

  const SingleBookScreen({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          title: Text(book.TITLE),
          backgroundColor: Colors.brown,
        ),
        body: SingleChildScrollView(
          child: Container(
//          padding: EdgeInsets.symmetric(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(
                    book.IMAGEURL.toLowerCase(),
                    fit: BoxFit.cover,
                    width: size.width / 2,
                    filterQuality: FilterQuality.high,
                  ),
//                height: 400,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Text(
                        'NAME:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        '${book.TITLE}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'WRITER:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.WRITER}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'GENRE:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.GENRES}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'NUMBER OF PAGES:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.PAGENUM}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'PUBLISH YEAR:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.PUBYEAR}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'ISBN:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.ISBN}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'RATING:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        '${book.RATING}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
