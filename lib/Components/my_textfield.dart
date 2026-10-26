import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_color.dart';

class MyTextField extends StatelessWidget{
  final LayerLink link;
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  //constructor
  MyTextField({
    super.key,
    required this.link,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText=false,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: link,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(color: AppColors().CrystalWhite
                  ,fontSize: 16,fontWeight: FontWeight.w700)
                  ,textAlign: TextAlign.start),
              SizedBox(height: 8),
              TextFormField(
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(color: AppColors().CrystalWhite),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 0),
                  prefixIcon: Icon(prefixIcon, color: AppColors().SoftCrystalWhite),
                  hintText: hintText,
                  hintStyle: TextStyle(color: AppColors().SoftCrystalWhite),
                  filled: true,
                  fillColor: AppColors().DeepSpace.withOpacity(0.8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors().SoftCrystalWhite, width: 1.4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors().ElectricPurple, width: 1.4),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}