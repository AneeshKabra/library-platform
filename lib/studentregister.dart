import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'studentlogin.dart';
import 'login.dart';

class S_register extends StatefulWidget {
  const S_register({Key? key}) : super(key: key);

  static String id = 'S_register';

  @override
  State<S_register> createState() => _S_register();
}

class _S_register extends State<S_register> {
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Student Registration'),
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.lightBlue[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SIGN UP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
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
                validator: (val) {
                  if (val != null && val.isNotEmpty) {
                    return null;
                  } else {
                    return "Enter an Email ID";
                  }
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
                validator: (val) {
                  if (val != null) {
                    if (val.length > 6) {
                      return null;
                    } else {
                      return "Enter a password 6+ characters long";
                    }
                  } else {
                    return "Enter an Email ID";
                  }
                },
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final new_user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (new_user != null) {
                      Navigator.pushNamed(context, S_login.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
