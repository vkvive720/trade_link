import 'dart:convert';


import 'package:http/http.dart' as http;

import '../global_varibles.dart';
import '../views/modules/banner_model.dart';



class BannerController{


//   fetch banners

  Future<List<BannerModel>>loadBanners ()async{

    try{
      final url = Uri.parse("$uri/api/banner");
      print(url);
      http.Response response= await http.get(url,headers: {
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