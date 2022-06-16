import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Delete_book extends StatefulWidget {
  const Delete_book({Key? key}) : super(key: key);

  static String id = 'Delete_book';

  @override
  State<Delete_book> createState() => _Delete_bookState();
}

class _Delete_bookState extends State<Delete_book> {
  final _firestore = FirebaseFirestore.instance.collection('books').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete a book'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore,
        builder: (context, AsyncSnapshot snapshot) {
          List<deletebookwidgets> bookTitle = [];
          if (snapshot.hasData) {
            final books = snapshot.data;

            if (books != null) {
              for (var book in books.docs) {
                final String booktitle = book.data()['Title'];
                final String bookauthor = book.data()['Author'];

                final bookid = book.data()['Book ID'];
                bookTitle.add(
                  deletebookwidgets(
                    title: booktitle,
                    author: bookauthor,
                    id: bookid,
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

class deletebookwidgets extends StatefulWidget {
  deletebookwidgets({
    required this.title,
    required this.author,
    required this.id,
  });
  final String title;
  final String author;
  final String id;

  @override
  State<deletebookwidgets> createState() => _deletebookwidgetsState();
}

class _deletebookwidgetsState extends State<deletebookwidgets> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final docbook = _firestore.collection('books').doc('${widget.id}');
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
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Delete'),
                onPressed: () async {
                  docbook.delete();
                },
              ),
              SizedBox(
                width: 10.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
