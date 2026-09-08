import 'package:flutter/material.dart';
import 'Favorite.dart';
import 'favorite_manager.dart';
import '../theme/app_color.dart';
import '../models/book_model.dart'; // Import the model we made in Step 1

class BookDetailsPage extends StatelessWidget {
  final Book book; // This is the "Data" passed from the previous screen

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().DeepSpace,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(book.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(book.imagePath, height: 300), // Dynamic Image
            Text(book.name, style: TextStyle(fontSize: 28, color: AppColors().CrystalWhite)),
            Text(book.author, style: TextStyle(color: AppColors().SoftLavender)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                book.summary,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppColors().SoftCrystalWhite,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  FavoritesManager.favoritesState[book.name] = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${book.name} added to Favorites!")),
                  );
                },
                child: Container(
                  height: 60,
                  width: double.infinity, // This makes it a "Bar"
                  decoration: BoxDecoration(
                    color: AppColors().ElectricPurple,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors().ElectricPurple.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Favorites",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}