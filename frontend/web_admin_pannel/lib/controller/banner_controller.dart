import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin_pannel/models/bannel.dart';
import 'package:web_admin_pannel/services/manage_http_response.dart';

import '../global_variable.dart';

class BannerController{

  uploadBanner({required dynamic pickedImage,required context})async
  {
    try{
      final cloudinary = CloudinaryPublic("dtnvzpzsv", "o8in1ps3");

      CloudinaryResponse imageResponse= await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(pickedImage, identifier: "picked_image",folder:"banners")
      );

      String image = imageResponse.secureUrl;

      BannerModel  bannerModel =BannerModel(id: "", image: image);
      
      http.Response respons=  await http.post(Uri.parse("$uri/api/banner"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: bannerModel.toJson(),
      );
      manageHttpResponse(response: respons, context: context, onSuccess: (){ showSnackBar(context, "Banner Uploaded");});

    }
    catch(e){
      print(e);
      showSnackBar(context, "unable to uploade banner: $e");

    }
  }
//   fetch banners

Future<List<BannerModel>>loadBanners ()async{

    try{
      http.Response response= await http.get(Uri.parse("$uri/api/banner"),headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },);
      print(response.body);
      if(response.statusCode==200)
        {
          print(response.body);

          List<dynamic> data = jsonDecode(response.body);
          List<BannerModel> banners = data
              .map((banner) => BannerModel.fromMap(banner as Map<String, dynamic>))
              .toList();

          return banners;
          
        }
      else{
        throw Exception("Failed to load Banner");
      }


    }
    catch(e){
      throw Exception("Failed to load Banner :$e");

    }





}

}