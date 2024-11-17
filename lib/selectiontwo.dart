import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class SelectionScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Overlay Effect
          Positioned.fill(
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Dark overlay for readability
            ),
          ),

          // Animated Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title with Fade Animation
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: Text(
                    'Blood Donation',
                    style: GoogleFonts.lobster(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Subtitle
                Text(
                  'Choose an option below to proceed:',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 40),

                // Animated Buttons
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
                      // "I Need Blood" Button
                      GlassyButton(
                        text: 'I Need Blood',
                        onPressed: () {
                          Navigator.pushNamed(context, '/requestBlood');
                        },
                      ),

                      SizedBox(height: 20),

                      // "I Want to Donate" Button
                      GlassyButton(
                        text: 'I Want To Donate',
                        onPressed: () {
                          Navigator.pushNamed(context, '/donateBlood');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GlassyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const GlassyButton({
    required this.text,
    required this.onPressed,
  });

  @override
  _GlassyButtonState createState() => _GlassyButtonState();
}

class _GlassyButtonState extends State<GlassyButton> {
  bool _isHovered = false; // Tracks hover state
  bool _isPressed = false; // Tracks press state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 250,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_isPressed
                ? 0.1 // Dim when pressed
                : _isHovered
                    ? 0.3 // Slightly brighter when hovered
                    : 0.2), // Default opacity
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: _isHovered ? 2 : 1, // Thicker border on hover
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX:
                    10 + (_isPressed ? 2 : 0), // Add extra blur when pressed
                sigmaY: 10 + (_isPressed ? 2 : 0),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isPressed
                        ? Colors.red.shade200
                        : _isHovered
                            ? Colors.red.shade100
                            : Colors.white,
                  ),
                  child: Text(widget.text),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
