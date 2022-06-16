import 'package:flutter/material.dart';
import 'studentlogin.dart';
import 'librarianlogin.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  static String id = 'login';

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen[200],
        appBar: AppBar(
          title: Center(
            child: Text('Library Management System'),
          ),
          backgroundColor: Colors.deepOrange[400],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you a student or a librarian?',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 140.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange[400],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, S_login.id);
                    },
                    child: Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[400]),
                    onPressed: () {
                      Navigator.pushNamed(context, L_login.id);
                    },
                    child: Text(
                      'Librarian',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
