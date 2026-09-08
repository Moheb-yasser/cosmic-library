import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart' show SfPdfViewer;
import 'favorite_manager.dart'; // Ensure correct path to manager

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Your central list of favorite-able books
  final List<Map<String, String>> favoriteBooks = [
    {'title': 'Atomic Habits', 'image': 'assets/atomic_habits.png', 'content':'assets/atomic_habits.pdf', 'author': 'James Clear'},
    {'title': 'Awaken The Giant', 'image': 'assets/awaken_the_giant.png', 'content':'assets/awaken_the_giant.pdf', 'author': 'Tony Robbins'},
    {'title': 'Can\'t Hurt Me', 'image': 'assets/cant_hurtme.png', 'content':'assets/cant_hurtme.pdf', 'author': 'David Goggins'},
    {'title': 'Fellow Travellers', 'image': 'assets/fellow_travellers.png', 'content':'assets/fellow_travellers.pdf', 'author': 'Thomas Mallon'},
    {'title': 'Laws of Power', 'image': 'assets/laws_of_power.png', 'content':'assets/the48lawsofpower.pdf', 'author': 'Robert Greene'},
    {'title': 'Surrounded By Idiots', 'image': 'assets/surrounded_by_idiots.png', 'content':'assets/surrounded_by_idiots.pdf', 'author': 'Thomas Erikson'},
    {'title': 'The Midnight Library', 'image': 'assets/the_midnight_library.png', 'content':'assets/midnight.pdf', 'author': 'Matt Haig'},
  ];

  @override
  Widget build(BuildContext context) {
    bool hasFavorites = FavoritesManager.favoritesState.values.contains(true);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B21),
      appBar: AppBar(
        title: const Text('My Cosmic Collection'),
        backgroundColor: Colors.transparent,
      ),
      body: !hasFavorites
          ? _buildEmptyState()
          : ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          String title = favoriteBooks[index]['title']!;


          if (FavoritesManager.favoritesState[title] == false) {
            return const SizedBox.shrink();
          }

          return Card(
            color: const Color(0xFF1A1A35),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(favoriteBooks[index]['image']!, width: 50),
              title: Text(title, style: const TextStyle(color: Colors.white)),
              subtitle: Text(favoriteBooks[index]['author']!, style: const TextStyle(color: Colors.white70)),

              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    // Flip the switch back to false
                    FavoritesManager.favoritesState[title] = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$title removed"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerPage(book: favoriteBooks[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.white38),
          SizedBox(height: 16),
          Text('Your library is empty.', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final Map<String, String> book;
  const PDFViewerPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book['title']!)),
      body: SfPdfViewer.asset(book['content']!),
    );
  }
}