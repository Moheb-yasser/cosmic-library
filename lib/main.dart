import 'package:flutter/material.dart';
import '../Pages/Welcome.dart';
import '../themes/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

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