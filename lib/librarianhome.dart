import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addbook.dart';
import 'deletebook.dart';

class L_home extends StatefulWidget {
  const L_home({Key? key}) : super(key: key);

  static String id = 'L_home';

  @override
  State<L_home> createState() => _L_homeState();
}

class _L_homeState extends State<L_home> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Admin Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Add_book.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, Delete_book.id);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Sign Out'),
          )
        ],
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        stream: _firestore.collection('books').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          List<libbookwidgets> booklist = [];
          if (snapshot.hasData) {
            final books = snapshot.data;
            if (books != null) {
              for (var book in books.docs) {
                final String booktitle = book.data()['Title'];
                final String bookauthor = book.data()['Author'];
                final bookavailability = book.data()['Availability'];
                final bookid = book.data()['Book ID'];
                final bookgenre = book.data()['Genre'];
                final bookuser = book.data()['User'];
                booklist.add(
                  libbookwidgets(
                    title: booktitle,
                    author: bookauthor,
                    availability: bookavailability,
                    id: bookid,
                    user: bookuser,
                    genre: bookgenre,
                  ),
                );
              }
            }
          }
          return ListView.builder(
              itemCount: booklist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: booklist[index],
                );
              });
        },
      ),
    );
  }
}

class libbookwidgets extends StatefulWidget {
  libbookwidgets({
    required this.title,
    required this.author,
    required this.availability,
    required this.id,
    required this.user,
    required this.genre,
  });
  final String title;
  final String author;
  bool availability;
  final String id;
  String user;
  final String genre;

  @override
  State<libbookwidgets> createState() => _libbookwidgetsState();
}

class _libbookwidgetsState extends State<libbookwidgets> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.button,
      color: Colors.deepOrange[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${widget.title}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
            ],
          ),
          Text(
            '${widget.author}'.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          Checkbox(
              value: !widget.availability,
              onChanged: (value) {
                setState(() {
                  final docuser =
                      _firestore.collection('books').doc('${widget.id}');
                  if (widget.availability == true) {
                    widget.availability = false;
                    widget.user = 'ADMIN';
                  } else {
                    widget.availability = true;
                    widget.user = '';
                  }
                  docuser.update({
                    'Availability': widget.availability,
                    'User': widget.user,
                  });
                });
              })
        ],
      ),
    );
  }
}
