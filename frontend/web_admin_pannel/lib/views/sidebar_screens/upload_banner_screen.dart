import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_pannel/controller/banner_controller.dart';
import 'package:web_admin_pannel/views/sidebar_screens/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({super.key});
  static String id = '\Upload-screen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  final BannerController _bannerController=BannerController();
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment:Alignment.topLeft ,
                    child: Text('Categories',style:TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),),
              ),
            ],
          ),
          Divider( color:Colors.grey,thickness: 2,),
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
                child: ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: ()async{
                      _bannerController.uploadBanner(pickedImage:_image, context: context);
      
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
          Divider( color:Colors.grey,thickness: 2,),
          BannerWidget(),
      
      
        ],
      
      ),
    );
  }
}
