import 'package:flutter/material.dart';
import '../themes/app_color.dart';
import '../models/book_model.dart';
import 'BookDetailsPage.dart';
import 'Favorite.dart'; // Import your favorite screen
import 'favorite_manager.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<Map<String, String>> allBooks = [
    {
      'title': 'Surrounded By Idiots',
      'image': 'assets/surrounded_by_idiots.png',
      'author': 'Thomas Erikson',
      'summary': 'This book explores the DISC model (Red, Yellow, Green, and Blue) to explain human behavior and communication styles.'
    },
    {
      'title': 'Fellow Travellers',
      'image': 'assets/fellow_travellers.png',
      'author': 'Thomas Mallon',
      'summary': 'A historical novel set during the "Lavender Scare" of the 1950s in Washington, D.C.'
    },
    {
      'title': 'Atomic Habits',
      'image': 'assets/atomic_habits.png',
      'author': 'James Clear',
      'summary': 'Clear focuses on the power of incremental change using the Cue, Craving, Response, Reward framework.'
    },
    {
      'title': 'Laws of Power',
      'image': 'assets/laws_of_power.png',
      'author': 'Robert Greene',
      'summary': 'A manual on the dynamics of power, drawing on 3,000 years of history.'
    },
    {
      'title': 'Can\'t Hurt Me',
      'image': 'assets/cant_hurtme.png',
      'author': 'David Goggins',
      'summary': 'David Goggins shares his journey from a traumatic childhood to becoming a Navy SEAL.'
    },
    {
      'title': 'The Midnight Library',
      'image': 'assets/the_midnight_library.png',
      'author': 'Matt Haig',
      'summary': 'A story about Nora Seed, who finds herself in a library between life and death.'
    },
    {
      'title': 'Awaken The Giant',
      'image': 'assets/awaken_the_giant.png',
      'author': 'Tony Robbins',
      'summary': 'A comprehensive guide to taking immediate control of your mental, emotional, physical, and financial destiny.'
    },
  ];

  List<Map<String, String>> displayedBooks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedBooks = allBooks;
  }

  void _handleSearch(String query) {
    setState(() {
      displayedBooks = allBooks.where((book) {
        final titleMatch = book['title']!.toLowerCase().contains(query.toLowerCase());
        final authorMatch = book['author']!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || authorMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().DeepSpace,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Cosmic Archive"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      hintText: "Search books...", 
                      hintStyle: const TextStyle(color: Colors.white38),
                      prefixIcon: Icon(Icons.search, color: AppColors().ElectricPurple),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors().ElectricPurple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                    );
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Icon(Icons.favorite, color: AppColors().ElectricPurple),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.6,
                ),
                itemCount: displayedBooks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(
                            book: Book(
                              name: displayedBooks[index]['title'] ?? 'Unknown',
                              author: displayedBooks[index]['author'] ?? 'Unknown Author',
                              summary: displayedBooks[index]['summary'] ?? 'No summary yet.',
                              imagePath: displayedBooks[index]['image'] ?? '',
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors().ElectricPurple.withOpacity(0.1),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                displayedBooks[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          displayedBooks[index]['title']!,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}