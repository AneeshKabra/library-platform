import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'googlesignin.dart';
import 'librarianhome.dart';
import 'studenthome.dart';
import 'studentlogin.dart';
import 'librarianlogin.dart';
import 'login.dart';
import 'studentregister.dart';
import 'addbook.dart';
import 'deletebook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Library());
}

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          initialRoute: login.id,
          routes: {
            login.id: (context) => login(),
            S_login.id: (context) => S_login(),
            S_register.id: (context) => S_register(),
            L_login.id: (context) => L_login(),
            S_home.id: (context) => S_home(),
            L_home.id: (context) => L_home(),
            Add_book.id: (context) => Add_book(),
            Delete_book.id: (context) => Delete_book(),
          },
        ),
      );
}
