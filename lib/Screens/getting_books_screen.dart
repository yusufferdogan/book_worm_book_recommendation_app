import 'package:book_worm/Models/recommendable_book.dart';
import 'package:book_worm/Screens/adding%20_book_screen.dart';
import 'package:book_worm/Widgets/book_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Provider/books.dart';
import 'package:provider/provider.dart';

class GettingBooksScreen extends StatefulWidget {
  @override
  _GettingBooksScreenState createState() => _GettingBooksScreenState();
}

class _GettingBooksScreenState extends State<GettingBooksScreen> {
//  var _isInit = true;
//  var _isLoading = false;
//  Future<void> _refreshProducts(BuildContext context) async {
//    await Provider.of<Books>(context, listen: false).fetchAndSetBooks();
//  }
//
//  @override
//  void didChangeDependencies() {
//    if (_isInit) {
//      _isLoading = true;
//      try {
//        Provider.of<Books>(context).fetchAndSetBooks().then(
//          (_) {
//            if (this.mounted) {
//              setState(() {
//                _isLoading = false;
//              });
//            }
//          },
//        );
//      } catch (error) {
//        print(error);
//        print('GettingBooksScreen ');
//      }
//      _isInit = false;
//    }
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Books>(context).fillBooks();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Books',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddingBookScreen.routeName),
          ),
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('books')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data.docs;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight,
                    child: ListView.builder(
                      itemCount: chatDocs.length,
                      itemBuilder: (context, index) {
                        print('length:${chatDocs.length}');
                        print('category ${chatDocs[index].data()['category']}');
                        print('id ${chatDocs[index].data()['id']}');
                        print('name ${chatDocs[index].data()['name']}');

                        return Column(
                          children: [
                            BookItem(
                              book: Book(
                                category: chatDocs[index].data()['category'],
//                                id: chatDocs[index].data()['id'],
                                id: '0',
                                name: chatDocs[index].data()['name'],
                                key: ValueKey(chatDocs[index].id),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
//      body: RefreshIndicator(
//        onRefresh: () {
//          return _refreshProducts(context);
//        },
//        child: _isLoading
//            ? Center(child: CircularProgressIndicator())
//            : LayoutBuilder(
//                builder: (BuildContext context, BoxConstraints constraints) {
//                  return Column(
//                    children: [
//                      Container(
//                        height: constraints.maxHeight,
//                        child: ListView.builder(
//                          itemCount: booksProvider.books.length,
//                          itemBuilder: (context, index) {
//                            return Column(
//                              children: [
//                                BookItem(
//                                  book: booksProvider.books[index],
//                                ),
//                                Divider(),
//                              ],
//                            );
//                          },
//                        ),
//                      ),
//                    ],
//                  );
//                },
//              ),
