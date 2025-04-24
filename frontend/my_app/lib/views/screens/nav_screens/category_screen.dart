import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controllers/subcategory_controller.dart';
import 'package:my_app/models/subcategories_model.dart';
import 'package:my_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:my_app/views/screens/nav_screens/widgets/popular_category_by_category_name.dart';

import '../../../controllers/category_controler.dart';
import '../../../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  List<Subcategory> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();

    // Set default category to "fasion" if found.
    futureCategories.then((categories) {
      for (var category in categories) {
        // Adjust the string comparison as needed (e.g., case-insensitive)
        if (category.name.toLowerCase() == "fasion") {
          setState(() {
            _selectedCategory = category;
          });
          _loadSubcategories(category.name);
          break;
        }
      }
    });
  }

  Future<void> _loadSubcategories(String categoryName) async {
    print("Entered load subcategory: $categoryName");
    final subcategories = await _subcategoryController.getSubcategoryByName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.16),
        child: const HeaderWidget(),
      ),
      body: Row(
        children: [
          // Left panel: Categories list
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder<List<Category>>(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Categories"));
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubcategories(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == category ? Colors.blue : Colors.black,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // Right panel: Category details, subcategories and popular products
          Expanded(
            flex: 5,
            child: _selectedCategory != null
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category name and banner
                  Text(
                    _selectedCategory!.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(_selectedCategory!.banner),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Subcategories grid
                  _subcategories.isEmpty
                      ? const Text("No subCategories")
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _subcategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                    ),
                    itemBuilder: (context, index) {
                      final subcategory = _subcategories[index];
                      return Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              subcategory.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subcategory.subcategoryName,
                            style: GoogleFonts.quicksand(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Popular products section for the selected category
                  // Expanded(
                  //   child: PopularProductsWidget(category: _selectedCategory!),
                  // ),
                ],
              ),
            )
                : Container(child: Text("hello"),),
          ),
        ],
      ),
    );
  }
}
