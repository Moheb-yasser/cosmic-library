import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Pages/Home.dart';
import '../Pages/Welcome.dart';
import '../Pages/SignUp.dart';
import '../themes/app_color.dart';
import '../components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/LoadingManager.dart';
import '../Pages/Home.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final List<LayerLink> _links = List.generate(2, (_) => LayerLink());
  final List<TextEditingController> _controllers = List.generate(2, (_) => TextEditingController());

  OverlayEntry? _errorOverlay; // The "Sticker" on the glass
  void _showError(int index, String message) {
    _hideError();
    _errorOverlay = OverlayEntry(
      builder: (context) => CompositedTransformFollower(
        link: _links[index],
        targetAnchor: Alignment.bottomCenter,
        followerAnchor: Alignment.topCenter,
        offset: Offset(0, 5),
        child: Align(
          alignment: Alignment.topCenter, // Center the bubble relative to the field
          child: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 250, // Set this to a reasonable width for your fields
                maxHeight: 100, // Allow it to grow vertically for long text
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors().SoftLavender.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message, textAlign: TextAlign.center, softWrap: true,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold
                    , fontSize: 16,),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_errorOverlay!);
  }
  // A helper function to remove the bubble when the user types
  void _hideError() {
    _errorOverlay?.remove();
    _errorOverlay = null;
  }
  @override
  void dispose() {
    _hideError(); // Wipe the sticker
    // Also clean the microphones so the app stays fast
    for (var c in _controllers) c.dispose();
    super.dispose();
  }
  void _startJourney() async{
    _hideError();

    // Check Email (Index 0)
    if (_controllers[0].text.isEmpty) {
      _showError(0, "Email is required!");
      return;
    }
    else if(!_controllers[0].text.contains('@gmail.com')||!_controllers[0].text.contains('.')){
      _showError(0, "Email must have @gmail.com");
      return;
    }
    // Check Password (Index 1)
    if (_controllers[1].text.isEmpty) {
      _showError(1, "Password is required!");
      return;
    }
    else if(_controllers[1].text.length<8){
      _showError(1, "Minimum 8 characters");
      return;
    }
    // If we reach here, everyone is safe!
    else{
      LoadingManager.showCustomLoading(context);
      try {
        // 1. Perform Login
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllers[0].text.trim(),
          password: _controllers[1].text.trim(),
        );
        // 2. SUCCESS: navigate to Home
        if (mounted) {
          // means are we still on our organic page that we wanted to move from
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage())
          );
        }
      } on FirebaseAuthException catch (e) {
        _showError(1, e.message ?? "Authentication failed");
      }
    }
  }
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //back button
                Row(
                  children: [
                    Padding(padding: EdgeInsetsGeometry.all(12),
                      child: GestureDetector(
                        onTap: () {
                          _hideError();
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> Welcome()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: AppColors().SoftCrystalWhite
                                ,fontWeight: FontWeight.w600),
                            SizedBox(width: 9),
                            Text("Back", style: GoogleFonts.poppins(
                              color: AppColors().SoftCrystalWhite,fontWeight: FontWeight.w600
                              ,fontSize: 20,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 160),
                SvgPicture.asset(
                  'assets/Open-Book--Streamline-Core.svg',
                  height: 70, color: AppColors().ElectricPurple,
                ),
                SizedBox(height: 20),
                Text("Welcome Back",style: GoogleFonts.montserrat(color: AppColors().SoftLavender,
                    fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: -0.2),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text("Sign in to continue your journey",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: AppColors().SoftCrystalWhite,
                        fontSize: 16,fontWeight: FontWeight.w800,letterSpacing: 0.5),
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Email field
                        MyTextField(
                          link: _links[0],
                          controller: _controllers[0],
                          label: "Email",
                          hintText: "your@email.com",
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: 28),
                        //Password field
                        MyTextField(
                          link: _links[1],
                          controller: _controllers[1],
                          obscureText: true,
                          label: "Password",
                          hintText: "********",
                          prefixIcon: Icons.lock_person_outlined,
                        ),
                        SizedBox(height: 48),
                        //Create Account button
                        ElevatedButton(
                          onPressed: _startJourney,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors().ElectricPurple,
                            minimumSize: Size(370, 60),
                          ),
                          child: Text("Log in",style: GoogleFonts.montserrat(fontWeight:
                          FontWeight.bold,fontSize: 22,color: AppColors().CrystalWhite,height: 3),
                          ),
                        ),
                        SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",style: GoogleFonts.poppins(
                        color: AppColors().SoftCrystalWhite,fontSize: 15,fontWeight:
                    FontWeight.w600,letterSpacing: 0.5),
                    ),
                    GestureDetector(
                      onTap: (){
                        _hideError();
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUp()));
                      },
                      child: Center(child: Text('Sign Up', style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(color: AppColors().ElectricPurple,
                              fontSize: 18,fontWeight: FontWeight.w600),
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 145),
              ],
            ),
          ),
        ),
      ),
    );
  }
}