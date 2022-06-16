import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class S_home extends StatefulWidget {
  const S_home({Key? key}) : super(key: key);

  static String id = 'S_home';

  @override
  State<S_home> createState() => _S_homeState();
}

class _S_homeState extends State<S_home> {
  final _firestore = FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Sign Out'),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore,
        builder: (context, AsyncSnapshot snapshot) {
          List<bookwidgets> bookTitle = [];
          if (snapshot.hasData) {
            final books = snapshot.data;

            if (books != null) {
              for (var book in books.docs) {
                final String booktitle = book.data()['Title'];
                final String bookauthor = book.data()['Author'];
                final bookavailability = book.data()['Availability'];
                final bookuser = book.data()['User'];
                final bookid = book.data()['Book ID'];
                final bookgenre = book.data()['Genre'];
                bookTitle.add(
                  bookwidgets(
                    title: booktitle,
                    author: bookauthor,
                    availability: bookavailability,
                    user: bookuser,
                    id: bookid,
                    genre: bookgenre,
                  ),
                );
              }
            }
          }
          return ListView.builder(
              itemCount: bookTitle.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: bookTitle[index],
                );
              });
        },
      ),
    );
  }
}

class bookwidgets extends StatefulWidget {
  bookwidgets({
    required this.title,
    required this.author,
    required this.availability,
    required this.user,
    required this.id,
    required this.genre,
  });
  final String title;
  final String author;
  bool availability;
  String user;
  final String id;
  final String genre;

  @override
  State<bookwidgets> createState() => _bookwidgetsState();
}

class _bookwidgetsState extends State<bookwidgets> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String useremail = '';
  @override
  Widget build(BuildContext context) {
    final docbook = _firestore.collection('books').doc('${widget.id}');
    return Material(
      type: MaterialType.button,
      color: Colors.lightBlue[100],
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
          Text(
            '${widget.genre}'.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          Checkbox(
              value: !widget.availability,
              onChanged: (value) {
                setState(() {
                  if (widget.availability == true) {
                    widget.availability = false;
                    widget.user = loggedInUser.email!;
                  } else {
                    if (loggedInUser.email == widget.user) {
                      widget.availability = true;
                      widget.user = '';
                    }
                  }
                  docbook.update({
                    'Availability': widget.availability,
                    'User': widget.user
                  });
                });
              })
        ],
      ),
    );
  }
}
