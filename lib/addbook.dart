import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'librarianhome.dart';

class Add_book extends StatefulWidget {
  const Add_book({Key? key}) : super(key: key);

  static String id = 'Add_book';

  @override
  State<Add_book> createState() => _Add_bookState();
}

class _Add_bookState extends State<Add_book> {
  String title = '';
  String author = '';
  String genre = '';
  bool availability = true;
  int year = 2000;
  String user = '';

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a book'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
              ),
              onChanged: (val) {
                setState(
                  () {
                    title = val;
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Author\'s Name',
              ),
              onChanged: (val) {
                setState(
                  () {
                    author = val;
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Genre',
              ),
              onChanged: (val) {
                setState(
                  () {
                    genre = val;
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Year of Publish',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(
                  () {
                    year = int.parse(value);
                  },
                );
              },
            ),
          ),
          SizedBox(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () async {
                final bookdata = _firestore.collection('books').doc();
                final json = {
                  'Title': title,
                  'Author': author,
                  'Genre': genre,
                  'Availability': availability,
                  'Year': year,
                  'User': user,
                  'Book ID': bookdata.id,
                };
                await bookdata.set(json);
                Navigator.pushNamed(context, L_home.id);
              },
              child: Text('Add Book'),
            ),
          ),
        ],
      ),
    );
  }
}
