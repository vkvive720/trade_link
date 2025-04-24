import 'package:flutter/material.dart';
import 'package:vendor_app/views/nav_screens/edit_screen.dart';
import 'package:vendor_app/views/nav_screens/order_screen.dart';
import 'package:vendor_app/views/nav_screens/upload_screen.dart';

import 'nav_screens/Earning_screen.dart';
import 'nav_screens/profile_screen.dart';


class VendorMainScreen extends StatefulWidget {
  const VendorMainScreen({Key? key}) : super(key: key);

  @override
  State<VendorMainScreen> createState() => _VendorMainScreenState();
}

class _VendorMainScreenState extends State<VendorMainScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [

    EarningScreen(),
    UploadScreen(),
    EditScreen(),
    OrderScreen(),
    VendorProfileScreen(),
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
            icon: Icon(
              Icons.attach_money_outlined,
              size: 25,
            ),
            label: "Earning",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
              size: 25,
            ),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
              size: 25,
            ),
            label: "Edit",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
            label: "order",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 25,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
