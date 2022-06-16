import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'librarianhome.dart';

class L_login extends StatefulWidget {
  const L_login({Key? key}) : super(key: key);

  static String id = 'L_login';

  @override
  State<L_login> createState() => _L_loginState();
}

class _L_loginState extends State<L_login> {
  String username = '';
  String password = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepOrange[100],
        appBar: AppBar(
          title: Center(
            child: Text('Librarian Login'),
          ),
          backgroundColor: Colors.red,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Username',
                        ),
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password',
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          if (username == 'SUTT_admin' &&
                              password == '1234567890') {
                            Navigator.pushNamed(context, L_home.id);
                          } else {
                            message = 'Invalid Credentials';
                          }
                        });
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(child: Text('$message')),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to main page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
