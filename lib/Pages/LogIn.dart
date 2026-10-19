import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_book/Pages/Home.dart';
import 'package:i_book/Pages/Welcome.dart';
import 'package:i_book/Pages/SignUp.dart';
import '../theme/app_color.dart';
import '../components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/LoadingManager.dart';
import 'package:i_book/Pages/Home.dart';
import 'dart:async';
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
  bool _isLoading = false;

  Future<void> _startJourney() async {
    if (_isLoading) return; // prevents double taps opening two dialogs
    _hideError();

    if (_controllers[0].text.isEmpty) {
      _showError(0, "Email is required!");
      return;
    } else if (!_controllers[0].text.contains('@gmail.com') ||
        !_controllers[0].text.contains('.')) {
      _showError(0, "Email must have @gmail.com");
      return;
    }
    if (_controllers[1].text.isEmpty) {
      _showError(1, "Password is required!");
      return;
    } else if (_controllers[1].text.length < 8) {
      _showError(1, "Minimum 8 characters");
      return;
    }

    _isLoading = true;
    LoadingManager.showCustomLoading(context);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _controllers[0].text.trim(),
        password: _controllers[1].text.trim(),
      )
          .timeout(const Duration(seconds: 15)); // escape hatch

      if (!mounted) return;
      LoadingManager.hide(context); // 1) close the dialog FIRST
      Navigator.pushReplacement(    // 2) then replace the LogIn page
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } on TimeoutException {
      if (!mounted) return;
      LoadingManager.hide(context);
      _showError(1, "Connection timed out. Please try again.");
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      LoadingManager.hide(context);
      _showError(1, _friendlyMessage(e.code));
    } catch (e) {
      // network errors, platform errors, anything unexpected
      if (!mounted) return;
      LoadingManager.hide(context);
      _showError(1, "Something went wrong. Please try again.");
    } finally {
      _isLoading = false;
    }
  }

  String _friendlyMessage(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return "Incorrect email or password";
      case 'too-many-requests':
        return "Too many attempts. Try again later";
      case 'network-request-failed':
        return "No internet connection";
      default:
        return "Authentication failed";
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
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
              //back button
              Row(
                children: [
                  Padding(padding: EdgeInsetsGeometry.all(12),
                    child: GestureDetector(
                      onTap: () {
                        _hideError();
                        Navigator.pop(context, MaterialPageRoute(builder: (c)=> Welcome()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: AppColors().SoftCrystalWhite
                              ,fontWeight: FontWeight.w600),
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
              SizedBox(height: 140),
              SvgPicture.asset(
                'assets/Open-Book--Streamline-Core.svg',
                height: 70, color: AppColors().ElectricPurple,
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                      SizedBox(height: 18),
                      //Password field
                      MyTextField(
                        link: _links[1],
                        controller: _controllers[1],
                        obscureText: true,
                        label: "Password",
                        hintText: "********",
                        prefixIcon: Icons.lock_person_outlined,
                      ),
                      SizedBox(height: 38),
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> SignUp()));
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
    );
  }
}