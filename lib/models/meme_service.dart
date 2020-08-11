import 'dart:convert';
import 'package:meme_app/models/images_helper.dart';
import 'package:http/http.dart' as http;

class MemeService {

  static final api = "https://api.imgflip.com/get_memes";

  List<ImagesHelper> imagesHelper;

  Future<List<ImagesHelper>> getData() async {
    var res = await http.get(api);
    var json = jsonDecode(res.body);
    imagesHelper = [];
    json["data"]["memes"].forEach((value) {
      var data = ImagesHelper.fromMap(value);
      imagesHelper.add(data);
    });
    return imagesHelper;
  }

}
