import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_pannel/views/sidebar_screens/buyers_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/category_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/order_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/product_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/subcategoty_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/upload_banner_screen.dart';
import 'package:web_admin_pannel/views/sidebar_screens/vendor_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VenderScreen();

  screenSelector(item) {
    if (item.route == BuyersScreen.id) {
      setState(() {
        _selectedScreen = BuyersScreen();
      });
    } else if (item.route == VenderScreen.id) {
      setState(() {
        _selectedScreen = VenderScreen();
      });
    } else if (item.route == OrderScreen.id) {
      setState(() {
        _selectedScreen = OrderScreen();
      });
    } else if (item.route == CategoriesScreen.id) {
      setState(() {
        _selectedScreen = CategoriesScreen();
      });
    } else if (item.route == UploadBannerScreen.id) {
      setState(() {
        _selectedScreen = UploadBannerScreen();
      });
    } else if (item.route == ProductScreen.id) {
      setState(() {
        _selectedScreen = ProductScreen();
      });

    }
    else if (item.route == SubcategotyScreen.id) {
      setState(() {
        _selectedScreen = SubcategotyScreen();
      });

    }

    else{
      setState(() {
        _selectedScreen = VenderScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd5deee),
        title: Text("Management"),
      ),
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Center(child:Text("Vendor Link ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1.7,color: Colors.white),)),
        ),
        items: [
          AdminMenuItem(
              title: "vendors",
              route: VenderScreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: "Buyers",
              route: BuyersScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: "Orders", route: OrderScreen.id, icon: Icons.shopping_cart),
          AdminMenuItem(
              title: "Categories",
              route: CategoriesScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: "SubCategories",
              route: SubcategotyScreen.id,
              icon: Icons.category_outlined),
          AdminMenuItem(
              title: "Upload Banner",
              route: UploadBannerScreen.id,
              icon: Icons.upload),
          AdminMenuItem(
              title: "Product",
              route: ProductScreen.id,
              icon: Icons.store),
        ],
        selectedRoute: VenderScreen.id,
        onSelected: (item){
          screenSelector(item);
        },
      ),
      body: _selectedScreen,
    );
  }
}
