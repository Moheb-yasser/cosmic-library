import 'package:flutter/material.dart';
import 'DiscoverPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../themes/app_color.dart';
import 'BookDetailsPage.dart';
import '../models/book_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().deepSpace,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            leading: IconButton(
              icon: Transform.flip(
                flipX: true,
                child: Icon(Icons.logout, color: AppColors().cosmicAccent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            centerTitle: true,
            title: Text(
              "IBook",
              style: TextStyle(
                color: AppColors().cosmicAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                // 1. About Us Section (Now at the top)
                const AboutUsSection(),

                const SizedBox(height: 10),

                // 2. Hero Slider
                HeroSlider(),

                // 3. Mini Product Slider Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Featured Books",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const ProductMiniSlider(),

                // Discover More Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors().cosmicAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DiscoverPage()),
                      );
                    },
                    child: Text("Discover More", style: TextStyle(color: AppColors().cosmicAccent)),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// --- Sub-Widgets ---

class HeroSlider extends StatelessWidget {
  final List<Map<String, String>> heroBooks = [
    {
      'title': 'Laws of Power',
      'image': 'assets/laws_of_power.png',
      'author': 'Robert Greene',
      'summary': 'A manual on the dynamics of power, drawing on 3,000 years of history.'
    },
    {
      'title': 'Atomic Habits',
      'image': 'assets/atomic_habits.png',
      'author': 'James Clear',
      'summary': 'Clear focuses on the power of incremental change using the Cue, Craving, Response, Reward framework.'
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

  HeroSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: heroBooks.map((bookData) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsPage(
                      book: Book(
                        name: bookData['title'] ?? 'Unknown',
                        author: bookData['author'] ?? 'Unknown Author',
                        summary: bookData['summary'] ?? 'No summary available.',
                        imagePath: bookData['image'] ?? '',
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [AppColors().royalPurple.withOpacity(0.5), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/galaxy_bg.jpg'), // Static cosmic background
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(bookData['image']!, height: 160),
                    const SizedBox(height: 10),
                    Text(
                      bookData['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class ProductMiniSlider extends StatelessWidget {
  const ProductMiniSlider({super.key});

  // The static constant list of books
  static const List<Map<String, String>> featuredBooks = [
    {
      'title': 'Laws of Power',
      'image': 'assets/laws_of_power.png',
      'author': 'Robert Greene',
      'summary': 'A manual on the dynamics of power, drawing on 3,000 years of history.'
    },
    {
      'title': 'Atomic Habits',
      'image': 'assets/atomic_habits.png',
      'author': 'James Clear',
      'summary': 'Clear focuses on the power of incremental change using the Cue, Craving, Response, Reward framework.'
    },
    {
      'title': 'Can\'t Hurt Me',
      'image': 'assets/cant_hurtme.png',
      'author': 'David Goggins',
      'summary': 'David Goggins shares his journey from a traumatic childhood to becoming a Navy SEAL.'
    },
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
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: featuredBooks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(
                    book: Book(
                      name: featuredBooks[index]['title'] ?? 'Unknown',
                      author: featuredBooks[index]['author'] ?? 'Unknown Author',
                      summary: featuredBooks[index]['summary'] ?? 'No summary available.',
                      imagePath: featuredBooks[index]['image'] ?? '',
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          featuredBooks[index]['image']!,
                          fit: BoxFit.cover,
                          // This handles the error if the image path is wrong
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.book,
                                size: 50, color: AppColors().cosmicAccent);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      featuredBooks[index]['title']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            "✨ Welcome to IBook",
            style: TextStyle(color: AppColors().cosmicAccent, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            "In the vast universe of stories, we believe everyone needs a quiet corner of the galaxy to call their own. IBook was born out of a shared love for the magic found between the pages of a book and the wonder of the stars above...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
          Text("Happy reading, traveler.",
              style: TextStyle(color: AppColors().cosmicAccent, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          text: "$name – ",
          style: TextStyle(color: AppColors().cosmicAccent, fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: role, style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}