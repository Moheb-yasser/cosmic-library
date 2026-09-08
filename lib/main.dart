import 'package:flutter/material.dart';
import 'package:i_book/Pages/Welcome.dart';
import 'package:i_book/theme/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_book/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(IBook());
}

class IBook extends StatelessWidget {
  const IBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors().DeepSpace,
        brightness: Brightness.dark,
      ),
      home: Welcome(),
    );
  }
}