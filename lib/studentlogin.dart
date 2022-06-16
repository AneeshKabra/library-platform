import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'googlesignin.dart';
import 'studentregister.dart';
import 'studenthome.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as font;

class S_login extends StatefulWidget {
  const S_login({Key? key}) : super(key: key);

  static String id = 'S_login';

  @override
  State<S_login> createState() => _S_loginState();
}

class _S_loginState extends State<S_login> {
  String email = '';
  String password = '';

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Center(
          child: Text('Student Login'),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email ID',
                ),
                onChanged: (val) {
                  setState(
                    () {
                      email = val;
                    },
                  );
                },
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, S_home.id);
                        }
                      } catch (e) {
                        print(e);
                        return null;
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  width: 100.0,
                  child: ElevatedButton.icon(
                    icon: font.FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      final variable = provider.googlelogin();
                      if (variable != null) {
                        Navigator.pushNamed(context, S_home.id);
                      }
                    },
                    label: Text('Login'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, S_register.id);
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back to main page'),
                )),
              ],
            )
          ]),
    ));
  }
}
