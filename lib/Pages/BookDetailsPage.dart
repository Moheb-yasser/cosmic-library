import 'package:flutter/material.dart';
import 'Favorite.dart';
import 'favorite_manager.dart';
import '../themes/app_color.dart';
import '../models/book_model.dart'; // Import the model we made in Step 1

class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Check if the current book is already marked as true in the manager
    bool isFavorite = FavoritesManager.favoritesState[widget.book.name] ?? false;

    return Scaffold(
      backgroundColor: AppColors().DeepSpace,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.book.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.book.imagePath, height: 300),
            Text(widget.book.name, style: TextStyle(fontSize: 28, color: AppColors().CrystalWhite)),
            Text(widget.book.author, style: TextStyle(color: AppColors().SoftLavender)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                widget.book.summary,
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
              child: Row(
                children: [
                  // READ BUTTON (Expanded takes up all available remaining width)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final Map<String, String> pdfMap = {
                          'Atomic Habits': 'assets/atomic_habits.pdf',
                          'Awaken The Giant': 'assets/awaken_the_giant.pdf',
                          'Can\'t Hurt Me': 'assets/cant_hurtme.pdf',
                          'Fellow Travellers': 'assets/fellow_travellers.pdf',
                          'Laws of Power': 'assets/the48lawsofpower.pdf',
                          'Surrounded By Idiots': 'assets/surrounded_by_idiots.pdf',
                          'The Midnight Library': 'assets/midnight.pdf',
                        };
                        String pdfPath = pdfMap[widget.book.name] ?? '';
                        if (pdfPath.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PDFViewerPage(
                                    book: {
                                      'title': widget.book.name,
                                      'content': pdfPath,
                                    },
                                  ),
                            ),
                          );
                        }
                        else {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("PDF not available for this book.")),
                        );
                        }
                      },
                      child: Container(
                        height: 60,
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
                            "Read",
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
                  const SizedBox(width: 15), // Spacing between buttons

                  // FAVORITE SQUARE BUTTON
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle the favorite status true/false
                        FavoritesManager.favoritesState[widget.book.name] = !isFavorite;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(!isFavorite
                              ? "${widget.book.name} added to Favorites!"
                              : "${widget.book.name} removed from Favorites"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 60, // Equal height and width makes a square
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white10),
                      ),
                      // Dynamically change icon based on state
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: AppColors().ElectricPurple,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}