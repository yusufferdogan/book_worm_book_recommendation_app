import 'package:book_worm/Widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../Provider/books.dart';

class AddingBookScreen extends StatefulWidget {
  static const routeName = '/AddingBookScreen';

  @override
  _AddingBookScreenState createState() => _AddingBookScreenState();
}

class _AddingBookScreenState extends State<AddingBookScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  List<String> genreList = [
    'History',
    'Crime',
    'Horror',
    'Biography',
    'Classic',
    'Science',
    'Adventure',
    'ScienceFiction',
    'YoungAdult',
    'Travel'
  ];
  String category = 'History';
  String name = '';
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    // this part is the error handling part
    try {
      await Provider.of<Books>(context, listen: false).addBook(
        Book(
          name: name,
          category: category,
        ),
      );
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text('Something went wrong'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Books'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name of the book',
                            fillColor: Colors.orangeAccent,
                            focusColor: Colors.orangeAccent,
                            hoverColor: Colors.orangeAccent,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a name.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            name = newValue;
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width / 2,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: DropdownButton<String>(
                    value: category,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 3,
                      color: Colors.orangeAccent,
                    ),
                    dropdownColor: Colors.orangeAccent,
                    onChanged: (String newValue) {
                      setState(() {
                        category = newValue;
                      });
                    },
                    items:
                        genreList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
