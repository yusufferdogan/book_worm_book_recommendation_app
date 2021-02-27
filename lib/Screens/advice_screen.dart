import 'package:book_worm/Models/recommendable_book.dart';
import 'package:book_worm/Provider/books.dart';
import 'package:book_worm/Widgets/reccommandeble_book_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      try {
        Provider.of<Books>(context, listen: false)
            .getAllRecommendableBooks()
            .then(
          (_) {
            if (this.mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            Provider.of<Books>(context, listen: false).recommendBooks();
            Provider.of<Books>(context, listen: false)
                .recommendedBooks
                .forEach((element) => print(element.toString()));
          },
        );
      } catch (error) {
        print(error);
        print('GettingBooksScreen ');
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('isinit: $_isInit');
    final booksProvider = Provider.of<Books>(context, listen: false);
    Future<void> _refreshProducts(BuildContext context) async {
      Provider.of<Books>(context, listen: false)
          .getAllRecommendableBooks()
          .then(
        (_) {
          if (this.mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          Provider.of<Books>(context, listen: false).recommendBooks();
          int v = Provider.of<Books>(context, listen: false)
              .recommendedBooks
              .length;
          print(v);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What to Read Next',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshProducts(context);
        },
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        child: ListView.builder(
                          itemCount: booksProvider.recommendedBooks.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RBookItem(
                                  book: booksProvider.recommendedBooks[index],
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
              ),
      ),
    );
  }
}
