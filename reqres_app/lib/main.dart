import 'package:flutter/material.dart';
import 'package:reqres_app/controller/auth_controller.dart';
import 'package:reqres_app/view/home_screen.dart';
import 'package:reqres_app/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:provider/provider.dart';
import 'services/provider.dart';
import 'view/profile.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TokenProvider>(
      create: (context) => TokenProvider(),
      child: MaterialApp(
        title: 'Reqres',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final token = snapshot.data?.getString('token');
              return token != null && token.isNotEmpty
                  ? MainScreen()
                  : LoginScreen(controller: AuthController());
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        routes: {
          '/main': (context) => MyApp(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/login': (context) => LoginScreen(controller: AuthController()),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TokenProvider>(
      builder: (context, tokenProvider, _) {
        if (tokenProvider.token != null && tokenProvider.token!.isNotEmpty) {
          return MainScreen();
        } else {
          return LoginScreen(controller: AuthController());
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SlidingClippedNavBar(
          backgroundColor: Colors.white,
          onButtonPressed: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          iconSize: 30,
          activeColor: Colors.blue,
          selectedIndex: _currentIndex,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home,
              title: 'Home',
            ),
            BarItem(
              icon: Icons.person,
              title: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
