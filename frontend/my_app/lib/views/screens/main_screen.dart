import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/views/screens/nav_screens/account_screen.dart';
import 'package:my_app/views/screens/nav_screens/cart_screen.dart';
import 'package:my_app/views/screens/nav_screens/category_screen.dart';
import 'package:my_app/views/screens/nav_screens/favioret_screen.dart';
import 'package:my_app/views/screens/nav_screens/home_screen.dart';
import 'package:my_app/views/screens/nav_screens/stores_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Favorite_Screen(),
    CategoryScreen(),
    StoresScreens(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the selected page
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        selectedItemColor: Colors.blue, // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/home.png"),

              size: 25,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/love.png"),
              size: 25,
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/love.png"),
              size: 25,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.category),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/cart.png"),
              size: 25,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/user.png"),
              size: 25,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
