import 'package:flutter/material.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/PersonalInfoBuilder.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/ProfileScreenBuilder.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/ProfileDisplayScreenBuilder.dart';
import 'package:nutria/Screens/loginsignup/index.dart';
import 'package:nutria/Screens/recommenderSystem/questions.dart';
import 'package:nutria/Screens/loginsignup/login.dart';
import 'package:nutria/Screens/loginsignup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutrIA',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 103, 138, 150),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 103, 138, 150),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This HomeScreen navigates through the initial flow.
    // In a real app, navigation from login/profile should be triggered
    // by actions within those screens (e.g., a login button press).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
      ).then((_) {
        // After login/signup page is presented (simulated completion),
        // navigate to profile setup.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreenBuilder()),
        ).then((_) {
          // After profile setup is presented (simulated completion),
          // navigate to the main app screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainAppScreen()),
          );
        });
      });
    });

    // Show a loading indicator or splash screen while navigating
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  // Pages to display based on footer selection
  static final List<Widget> _pages = <Widget>[
    Questions(), // Get recommendation (Index 0)
    const ProfileDisplayScreenBuilder(), // View Profile (Index 1)
    const ChatbotDummyPage(), // Chatbot (Index 2)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NutrIA'),
        backgroundColor: const Color.fromARGB(255, 103, 138, 150),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 103, 138, 150), // Accent color
        foregroundColor: Colors.white,
        onPressed: () {
          _onItemTapped(2); // Navigate to Chatbot
        },
        child: const Icon(Icons.chat_bubble), // Chatbot icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomPaint(
        painter: BottomNavCurvePainter(Theme.of(context).primaryColor), // Use the custom painter
        child: BottomAppBar(
          elevation: 0, // Remove default elevation
          color: Colors.transparent, // Make BottomAppBar transparent
          shape: const CircularNotchedRectangle(), // Still needed for FAB docking
          notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // Keep padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.recommend, color: _selectedIndex == 0 ? const Color.fromARGB(255, 103, 138, 150) : Colors.grey), // Recommend
                  onPressed: () => _onItemTapped(0),
                ),
                // Placeholder for the central button - actual FAB is used
                const SizedBox(width: 48), // The size of the FAB
                IconButton(
                  icon: Icon(Icons.person, color: _selectedIndex == 1 ? const Color.fromARGB(255, 103, 138, 150) : Colors.grey), // Profile
                  onPressed: () => _onItemTapped(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatbotDummyPage extends StatelessWidget {
  const ChatbotDummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chatbot Page (Coming Soon)',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Custom Painter for the bottom navigation bar shape
class BottomNavCurvePainter extends CustomPainter {
  const BottomNavCurvePainter(this.centerColor);

  final Color centerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // White background color
      ..style = PaintingStyle.fill;

    final path = Path();
    const double buttonSize = 60; // Approximate size of the FAB
    final double notchRadius = buttonSize / 2 + 8; // Radius of the notch based on FAB size and margin

    const double iconSpacing = 40; // Approximate space between icons and curves
    const double curveHeight = 20; // Height of the curves around the icons

    path.moveTo(0, curveHeight); // Start with a curve from the bottom left
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.25 - iconSpacing, 0); // Curve up towards the first icon

    // Curve around the first icon (Recommend)
    path.arcToPoint(Offset(size.width * 0.25 + iconSpacing, 0), 
        radius: Radius.circular(curveHeight), clockwise: false); // Curve around the icon

    path.quadraticBezierTo(size.width * 0.4, 0, size.width / 2 - notchRadius, 0); // Curve towards the central notch

    // Notch for the central button (Chatbot)
    path.arcToPoint(Offset(size.width / 2 + notchRadius, 0), 
        radius: Radius.circular(notchRadius), clockwise: false); // Curve around the notch

    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.75 - iconSpacing, 0); // Curve towards the second icon
    
    // Curve around the second icon (Profile)
     path.arcToPoint(Offset(size.width * 0.75 + iconSpacing, 0), 
        radius: Radius.circular(curveHeight), clockwise: false); // Curve around the icon

    path.quadraticBezierTo(size.width * 0.9, 0, size.width, curveHeight); // Curve down to the bottom right edge
    
    path.lineTo(size.width, size.height); // Line to the bottom right
    path.lineTo(0, size.height); // Line to the bottom left
    path.close(); // Close the path

    canvas.drawPath(path, paint);

    // Optionally draw a subtle shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5); // Apply blur
    
    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Can set to true if the shape needs to change dynamically
  }
}