import 'package:book_worm/Screens/advice_screen.dart';
import 'package:book_worm/Screens/getting_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': GettingBooksScreen(),
      'title': 'Add Your Books',
    },
    {
      'page': AdviceScreen(),
      'title': 'What To Read Next',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text(_pages[_selectedPageIndex]['title']),
//      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedFontSize: 20,
        unselectedFontSize: 15,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
//            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              MdiIcons.book,
              size: 25,
            ),
            title: Text(
              'Your Books',
            ),
          ),
          BottomNavigationBarItem(
//            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              MdiIcons.bookSearchOutline,
              size: 25,
            ),
            title: Text(
              'Recommend',
            ),
          ),
        ],
      ),
    );
  }
}
