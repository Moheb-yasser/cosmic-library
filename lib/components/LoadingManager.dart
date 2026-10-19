import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_color.dart';
class LoadingManager {
  //Method 1: Default Material Loader
  static void showDefaultLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: AppColors().ElectricPurple,
          strokeWidth: 5,
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    // showDialog uses the root navigator by default, so pop from the root
    Navigator.of(context, rootNavigator: true).pop();
  }

  //Method 2: Custom Branded SVG Loader
  static void showCustomLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CustomRotatingSVG(),
      ),
    );
  }
}
class CustomRotatingSVG extends StatefulWidget {
  const CustomRotatingSVG({super.key});

  @override
  State<CustomRotatingSVG> createState() => _CustomRotatingSVGState();
}

class _CustomRotatingSVGState extends State<CustomRotatingSVG>
    with SingleTickerProviderStateMixin {
  // The "Heartbeat" ( Metronome: updating the image position per second
  // as it sends 60 signals per sec )
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Brain
    _controller = AnimationController(
      vsync: this, // Tells the controller to sync with the screen refresh
      duration: Duration(seconds: 3), // Speed: number of cycle per sec
    )..repeat(); // CRITICAL: tells the animation to loop clockwise
  }

  @override
  void dispose() {
    _controller.dispose(); // CRITICAL: Stops the heartbeat when the dialog closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The "Body" that performs the move
    return RotationTransition(
      turns: _controller, // Maps 0.0 -> 1.0 to a full 360-degree turn
      child: SvgPicture.asset('assets/Black-Hole--Streamline-Solar.svg',
        height: 100, color: AppColors().ElectricPurple,
      ),
    );
  }
}