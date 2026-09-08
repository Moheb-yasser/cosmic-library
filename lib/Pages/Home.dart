import 'package:flutter/material.dart';
import '../theme/app_color.dart';
import 'DiscoverPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().DeepSpace,
      body: CustomScrollView(
        slivers: [
          // 1. Header Widget
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            centerTitle: true,
            title: Text(
              "IBook",
              style: TextStyle(
                color: AppColors().SoftLavender,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: AppColors().SoftLavender),
                onPressed: () {},
              ),
            ],
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
                      side: BorderSide(color: AppColors().SoftLavender),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DiscoverPage()),
                      );
                    },
                    child: Text("Discover More", style: TextStyle(color: AppColors().SoftLavender)),
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
  final List<String> imgList = [
    'assets/laws_of_power.png', // Replace with your assets
    'assets/atomic_habits.png',
    'assets/cant_hurtme.png',
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
      items: imgList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
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
              child: Center(
                child: Image.asset(i, height: 180), // The "floating" book image
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
      'title': 'Awaken The Giant',
      'image': 'assets/awaken_the_giant.png',
    },
    {
      'title': 'Fellow Travelers',
      'image': 'assets/fellow_travellers.png',
    },
    {
      'title': 'Surrounded By Idiots',
      'image': 'assets/surrounded_by_idiots.png',
    },
    {
      'title': 'The Midnight Library',
      'image': 'assets/the_midnight_library.png',
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
          return Container(
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
                              size: 50, color: AppColors().SoftLavender);
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
            style: TextStyle(color: AppColors().SoftLavender, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            "In the vast universe of stories, we believe everyone needs a quiet corner of the galaxy to call their own. IBook was born out of a shared love for the magic found between the pages of a book and the wonder of the stars above...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
          Divider(color: AppColors().SoftLavender, height: 40),
          const Text("🌌 The Team Behind the Stars",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildTeamMember("Menna Hamada", "The Architect of Elegance"),
          _buildTeamMember("Moheb Yasser", "The Logic Voyager"),
          _buildTeamMember("Hussain Farooq", "The Creative Visionary"),
          const SizedBox(height: 20),
          Text("Happy reading, traveler.",
              style: TextStyle(color: AppColors().SoftLavender, fontStyle: FontStyle.italic)),
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
          style: TextStyle(color: AppColors().SoftLavender, fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: role, style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}