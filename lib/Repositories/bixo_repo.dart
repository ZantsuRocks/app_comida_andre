import 'dart:convert';

import 'package:http/http.dart';

import '../Models/bixo.dart';

class BixoRepo {
  // static String startPath = 'http://192.168.4.1';
  static String startPath = 'http://192.168.0.16/api/v1/';
  static Uri _urlGet = Uri.parse('${startPath}get');
  static Uri _urlPost = Uri.parse('${startPath}post');
  static Uri _urlImageGet = Uri.parse('${startPath}image-get');
  static Uri _urlImagePost = Uri.parse('${startPath}image-post');

  static Future<Bixo> fillBixo({Bixo? bixoToFill}) async {
    Response response = await get(_urlGet);

    if (response.statusCode == 200) {
      Map<String, dynamic> fromGet = jsonDecode(response.body);

      if (bixoToFill != null) {
        bixoToFill.replaceFromJson(fromGet);
        return bixoToFill;
      }
      return Bixo()..replaceFromJson(fromGet);
    } else {
      throw (Exception('Response Code was: ${response.statusCode}'));
    }
  }

  static Future<Bixo> fillBixoImage({Bixo? bixoToFill}) async {
    Response response = await get(_urlImageGet);

    if (response.statusCode == 200) {
      if (bixoToFill != null) {
        bixoToFill.fotoAsBytes = response.bodyBytes;
        return bixoToFill;
      }
      return Bixo()..fotoAsBytes = response.bodyBytes;
    } else {
      throw (Exception('Response Code was: ${response.statusCode}'));
    }
  }

  static Future<Bixo> sendBixo(Bixo bixoToSend, {Bixo? bixoToReplace}) async {
    Map<String, dynamic> _bixoJson = bixoToSend.toJson();
    String bixoJson = jsonEncode(_bixoJson);

    Response response = await post(
      _urlPost,
      body: bixoJson,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      if (bixoToReplace != null) {
        bixoToReplace.replaceFromJson(_bixoJson);
        return bixoToReplace;
      }
      return Bixo()..replaceFromJson(_bixoJson);
    } else {
      throw (Exception('Response Code was: ${response.statusCode}'));
    }
  }
}
