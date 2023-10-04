import 'package:flutter/material.dart';
import 'package:flutter_app_cuoiky1/pages/home_page.dart';
import 'package:flutter_app_cuoiky1/pages/infomation_page.dart';
import 'package:flutter_app_cuoiky1/pages/search_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> tabs = [
    const HomePage(),
    const SearchPage(),
    const InfomationPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (value) {
            currentIndex = value;
            setState(() {});
          },
          backgroundColor: Colors.blue,
          tabBackgroundColor: const Color.fromARGB(255, 9, 93, 237),
          padding: const EdgeInsets.all(16.0),
          gap: 20.0,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.info,
              text: 'Infomation',
            ),
          ],
        ),
      ),
    );
  }
}
