import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_pannel/controller/category_controller.dart';
import 'package:web_admin_pannel/views/sidebar_screens/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static String id = 'category-screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  final CategoryController  _categoryController = CategoryController();
  late String category_name;
  dynamic _image;
  dynamic _banner_image;
  pickImage()async{
    FilePickerResult? result= await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if(result!=null)
      {
        setState(() {
          _image = result.files.first.bytes;
        });
      }
  }
  pickBanner()async{
    FilePickerResult? result= await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if(result!=null)
    {
      setState(() {
        _banner_image = result.files.first.bytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text('Categories',style:TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,height: 150,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(5)),
                    child: Center(child: _image!=null?
                        Image.memory(_image):
                    Text("category Image"),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: TextFormField(
                      onChanged: (value){
                        category_name=value;
                      },
                      validator: (value){
                        if(value!.isEmpty) return "Please enter caegory name";
                        else return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter category name"
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: ()async{
                        _categoryController.uploadCategory(pickedImage: _image, pickedBanner: _banner_image, name: category_name, context: context);

                      }, child: Text("save",style: TextStyle(color: Colors.white),)),
                ),

              ],

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: (){
                    pickImage();
                  },
                  child: Text("pick image",style: TextStyle(color: Colors.white))),
            ),
            Divider(color:Colors.grey),
            Container(
            width: 150,height: 150,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(5)),
            child: Center(child: _banner_image!=null?
            Image.memory(_banner_image):
            Text("category Banner"),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: (){
                    pickBanner();
                  },
                  child: Text("pick image",style: TextStyle(color: Colors.white))),
            ),
            Divider(color:Colors.grey),
            CategoryWidget(),

          ],

        ),
      ),
    );

  }
}
