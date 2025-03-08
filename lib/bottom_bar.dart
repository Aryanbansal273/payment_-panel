import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'cardui.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [
    const CardUI(),
    const Center(
        child: Text("Yolo Pay",
            style: TextStyle(fontSize: 20, color: Colors.white))),
    const Center(
        child: Text("Genie Screen",
            style: TextStyle(fontSize: 20, color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: CurvedLinePainter(),
              size: const Size(double.infinity, 100),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: Colors.black,
              buttonBackgroundColor: Colors.black,
              height: 65,
              index: _selectedIndex,
              animationDuration: const Duration(milliseconds: 300),
              items: [
                _buildNavItem(LucideIcons.home, "home", 0),
                _buildNavItem(LucideIcons.qrCode, "yolo pay", 1),
                _buildNavItem(LucideIcons.badgePercent, "ginie", 2),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: Colors.white38, width: 1)
                : null, // Use Border.all for border
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: isSelected
                    ? [
                  Colors.white,
                  Colors.white.withOpacity(0.0)
                ] // White to Transparent for selected
                    : [
                  Colors.grey.shade700,
                  Colors.grey.shade900
                ], // Grey for unselected
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Icon(
              icon,
              size: 26,
              color:
              Colors.white, //  Base color, gradient will be applied on top
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 1.0  // Adjust line thickness here if needed
      ..style = PaintingStyle.stroke;

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.6),
        Colors.white.withOpacity(0.0),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}