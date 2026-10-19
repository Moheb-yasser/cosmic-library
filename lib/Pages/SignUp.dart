import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_book/Pages/Welcome.dart';
import 'package:i_book/Pages/LogIn.dart';
import '../components/LoadingManager.dart';
import '../theme/app_color.dart';
import '../components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_book/Pages/Home.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<LayerLink> _links = List.generate(5, (_) => LayerLink());
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

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

    // Check First Name (Index 0)
    if (_controllers[0].text.isEmpty) {
      _showError(0, "First Name is required!");
      return;
    }
    // Check Last Name (Index 1)
    if (_controllers[1].text.isEmpty) {
      _showError(1, "Last Name is required!");
      return;
    }
    // Check Email (Index 2)
    if (_controllers[2].text.isEmpty) {
      _showError(2, "Email is required!");
      return;
    }
    else if(!_controllers[2].text.contains('@gmail.com')||!_controllers[2].text.contains('.')){
      _showError(2, "Email must have @gmail.com");
      return;
    }
    // Check Password (Index 3)
    if (_controllers[3].text.isEmpty) {
      _showError(3, "Password is required!");
      return;
    }
    else if(_controllers[3].text.length<8){
      _showError(3, "Minimum 8 characters");
      return;
    }
    // Check Confirm Password (Index 4)
    if (_controllers[4].text.isEmpty) {
      _showError(4, "Confirm Password is required!");
      return;
    }
    else if(_controllers[4].text!=_controllers[3].text){
      _showError(4, "Passwords don't match");
      return;
    }
    // If we reach here, everyone is safe!
    else{
      LoadingManager.showCustomLoading(context);
      try {
        // Creating the account
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllers[2].text.trim(), // Use index for email field
          password: _controllers[3].text.trim(), // Use index for password field
        );
        //getting user id to connect (first , last) name and email to user id
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'firstName': _controllers[0].text.trim(),
          'lastName': _controllers[1].text.trim(),
          'email': _controllers[2].text.trim(),
        });
        if (mounted) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        // Logic: If we reach this line, it worked!
        // Now we would move to the Welcome or Home screen.
      } on FirebaseAuthException catch (e) {
        if (mounted) Navigator.pop(context);
        // Handle specific errors like 'email-already-in-use'
        _showError(2, e.message ?? "Registration Failed");
      }
      catch (e) {
        if (mounted) Navigator.pop(context);
        _showError(1, "An unexpected error occurred");
      }
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
              SvgPicture.asset(
                'assets/Open-Book--Streamline-Core.svg',
                height: 65, color: AppColors().ElectricPurple,
              ),
              SizedBox(height: 8),
              Text("Create Account",style: GoogleFonts.montserrat(color: AppColors().SoftLavender,
                  fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: -0.2),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text("Join the cosmic library",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: AppColors().SoftCrystalWhite,
                      fontSize: 15,fontWeight: FontWeight.w700,letterSpacing: 0.5),
                ),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //First name field
                      MyTextField(
                        link: _links[0],
                        controller: _controllers[0],
                        label: "First Name",
                        hintText: "Moheb",
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: 10),
                      //Last name field
                      MyTextField(
                        link: _links[1],
                        controller: _controllers[1],
                        label: "Last Name",
                        hintText: "Yasser",
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: 10),
                      //Email field
                      MyTextField(
                        link: _links[2],
                        controller: _controllers[2],
                        label: "Email",
                        hintText: "your@gmail.com",
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: 10),
                      //Password field
                      MyTextField(
                        link: _links[3],
                        controller: _controllers[3],
                        obscureText: true,
                        label: "Password",
                        hintText: "********",
                        prefixIcon: Icons.lock_person_outlined,
                      ),
                      SizedBox(height: 10),
                      //Confirm Password field
                      MyTextField(
                        link: _links[4],
                        controller: _controllers[4],
                        obscureText: true,
                        label: "Confirm Password",
                        hintText: "********",
                        prefixIcon: Icons.lock_person_outlined,
                      ),
                      SizedBox(height: 18),
                      //Create Account button
                      ElevatedButton(
                        onPressed: _startJourney,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().ElectricPurple, minimumSize: Size(370, 60),
                        ),
                        child: Text("Create Account",style: GoogleFonts.montserrat(fontWeight:
                        FontWeight.bold,fontSize: 22,color: AppColors().CrystalWhite,height: 3),
                        ),
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",style: GoogleFonts.poppins(color: AppColors().SoftCrystalWhite,
                      fontSize: 14,fontWeight: FontWeight.w600,letterSpacing: 0.5),
                  ),
                  GestureDetector(
                    onTap: (){
                      _hideError();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> LogIn()));
                    },
                    child: Container(
                      child: Center(child: Text(
                        'Log In',
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(color: AppColors().ElectricPurple,
                              fontSize: 18,fontWeight: FontWeight.w600),
                        ),
                      ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}