import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_book/Pages/SignUp.dart';
import 'package:i_book/Pages/LogIn.dart';
import 'package:i_book/theme/app_color.dart';
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome-background-4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CosmicBook(),
            SvgPicture.asset(
              'assets/Open-Book--Streamline-Core.svg',
              height: 100, color:AppColors().ElectricPurple,
            ),
            SizedBox(height: 21),
            Text("IBook",style: GoogleFonts.montserrat(color: AppColors().SoftLavender,
            fontSize: 45,fontWeight: FontWeight.bold,letterSpacing: -0.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Astronomy-Saturn-Star--Streamline-Nova.png',
                  height:32,color: AppColors().SoftLavender),
                Text(" Your Cosmic Library ",
                    style: GoogleFonts.poppins(color: AppColors().CrystalWhite,
                        fontSize: 16,fontWeight: FontWeight.w800)
                ),
                Image.asset('assets/Astronomy-Saturn-Star--Streamline-Nova.png',
                  height:32,color: AppColors().SoftLavender),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(12),
                child: Text("Explore infinite worlds, discover timeless stories, "
                    "and journey through the universe of literature",
                textAlign: TextAlign.center, style: GoogleFonts.poppins(
                      color: AppColors().SoftCrystalWhite,fontSize: 14,
                      fontWeight: FontWeight.w700,letterSpacing: 0.5),
                ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUp()))
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors().ElectricPurple,
              ),
              child: Text("Begin Your Journey",style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,fontSize: 22,
                  color: AppColors().CrystalWhite,height: 3),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",style: GoogleFonts.poppins(
                    color: AppColors().SoftCrystalWhite,fontSize: 14,
                    fontWeight: FontWeight.w600,letterSpacing: 0.5),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> LogIn()));
                  },
                  child: Center(child: Text('Log In', style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(color: AppColors().ElectricPurple,
                          fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// class CosmicBook extends StatefulWidget{
//   const CosmicBook({super.key});
//
//   @override
//   State<CosmicBook> createState() => _CosmicBookState();
// }
// class _CosmicBookState extends State<CosmicBook> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this, // Now vsync works because of the Mixin!
//     )..repeat(reverse: true);
//
//     _animation = Tween<double>(begin: 0, end: -15).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _animation.value),
//           child: child,
//         );
//       },
//       child: SvgPicture.asset(
//         'assets/Open-Book--Streamline-Core.svg',
//         height: 100, color: AppColors().ElectricPurple,
//       ),
//     );
//   }
// }