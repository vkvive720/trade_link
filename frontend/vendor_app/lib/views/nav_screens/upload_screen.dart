import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app/models/category_model.dart';
import 'package:vendor_app/models/sub_category_model.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/subCategory_controller.dart';
import '../../models/product_controller.dart';


class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ImagePicker picker = ImagePicker();
  List<File> images = [];

  // Product detail fields using state variables
  String productName = '';
  int price = 0;
  int quantity = 0;
  String description = '';

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  late Future<List<Category>> futureCategories;
  Category? selectedCategory;

  Future<List<Subcategory>>? futureSubCategory;
  Subcategory? selectedSubcategory;

  final CategoryController _categoryController = CategoryController();
  final SubcategoryController _subCategoryController = SubcategoryController();
  final ProductController _productController = ProductController();

  // Controls the visibility of the progress indicator
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    futureCategories = _categoryController.loadCategories();
  }

  /// Function to choose an image from the gallery.
  Future<void> chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      print('No image picked');
      return;
    }
    setState(() {
      images.add(File(pickedFile.path));
    });
  }

  /// Fetch subcategories based on the selected category.
  void getSubcategoryByCategory(Category category) {
    setState(() {
      futureSubCategory =
          _subCategoryController.getSubcategoryByName(category.name);
      selectedSubcategory = null; // Reset subcategory when category changes.
    });
  }

  /// Calls the actual upload logic in ProductController.
  Future<void> _uploadProduct() async {
    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Check for missing selections
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a category.")));
      return;
    }
    if (selectedSubcategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a subcategory.")));
      return;
    }
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please pick at least one image")));
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      await _productController.uploadProduct(
        productName: productName,
        fullName: 'Your Full Name', // Replace with your full name or vendor name
        productPrice: price, // price is already an int
        quantity: quantity,
        description: description,
        category: selectedCategory!.name,
        subCategory: selectedSubcategory!.subcategoryName,
        vendorId: 'vendorID', // Replace with the actual vendor ID
        pickedImages: images,
        context: context,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Product")),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Dropdown
                  FutureBuilder<List<Category>>(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No Categories"));
                      } else {
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownButton<Category>(
                            hint: const Text("Select Category"),
                            value: selectedCategory,
                            isExpanded: true,
                            items: snapshot.data!
                                .map((Category category) =>
                                DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.name),
                                ))
                                .toList(),
                            onChanged: (Category? value) {
                              setState(() {
                                selectedCategory = value;
                                if (selectedCategory != null) {
                                  getSubcategoryByCategory(selectedCategory!);
                                  print(
                                      "Selected Category: ${selectedCategory!.name}");
                                }
                              });
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Subcategory Dropdown (if category selected)
                  futureSubCategory == null
                      ? const SizedBox.shrink()
                      : FutureBuilder<List<Subcategory>>(
                    future: futureSubCategory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text("Error: ${snapshot.error}"));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("No Subcategories"));
                      } else {
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownButton<Subcategory>(
                            hint: const Text("Select Subcategory"),
                            value: selectedSubcategory,
                            isExpanded: true,
                            items: snapshot.data!
                                .map((Subcategory subcategory) =>
                                DropdownMenuItem<Subcategory>(
                                  value: subcategory,
                                  child: Text(subcategory.subcategoryName),
                                ))
                                .toList(),
                            onChanged: (Subcategory? value) {
                              setState(() {
                                selectedSubcategory = value;
                                if (selectedSubcategory != null) {
                                  print(
                                      "Selected Subcategory: ${selectedSubcategory!.subcategoryName}");
                                }
                              });
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // Product Name field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        productName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Product Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Price field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        price = int.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Price is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Quantity field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Quantity is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Description field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Image picker and preview
                  ElevatedButton(
                    onPressed: chooseImage,
                    child: const Text("Add Image"),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: images
                        .map((img) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.file(
                        img,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isUploading ? null : _uploadProduct,
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Progress indicator overlay
          if (isUploading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
