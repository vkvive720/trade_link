import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_pannel/controller/category_controller.dart';
import 'package:web_admin_pannel/controller/subCategory_controller.dart';
import 'package:web_admin_pannel/views/sidebar_screens/widgets/subcategory_widget.dart';
import '../../models/category_screen.dart';

class SubcategotyScreen extends StatefulWidget {
  const SubcategotyScreen({super.key});
  static String id = 'subcategory-screen';

  @override
  State<SubcategotyScreen> createState() => _SubcategotyScreenState();
}

class _SubcategotyScreenState extends State<SubcategotyScreen> {
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  final SubCategoryController _subCategoryController = SubCategoryController();
  late String category_name;
  dynamic _image;
  dynamic _banner_image;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    futureCategories = _categoryController.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sub Categories header
              const Text(
                'Sub Categories',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.grey),

              // Dropdown to select a category
              FutureBuilder<List<Category>>(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Categories"));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButton<Category>(
                        hint: const Text("Select Category"),
                        value: selectedCategory,
                        items: snapshot.data!.map((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (Category? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                          if (selectedCategory != null) {
                            print(selectedCategory!.name);
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // Categories Section header
              const Text(
                'Categories',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.grey),

              // Row with image preview, text input, and a placeholder button
              Form(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container for category image preview
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: _image != null
                            ? Image.memory(_image)
                            : const Text("SubCategory Image"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Expanded TextFormField for category name input
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          category_name = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Subcategory name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Enter category name",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Placeholder TextButton for additional action
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (selectedCategory == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please select a category")),
                                );
                                return;
                              }
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please pick an image")),
                                );
                                return;
                              }
                              await _subCategoryController.uploadSubcategory(
                                categoryId: selectedCategory!.id,
                                categoryName: selectedCategory!.name,
                                pickedImage: _image,
                                subCategoryName: category_name,
                                context: context,
                              );
                            }
                          },
                           child: Text("save",style: TextStyle(color: Colors.white),)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Elevated button to pick an image
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: pickImage,
                child: const Text(
                  "Pick Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(color: Colors.grey),

              SubcategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
