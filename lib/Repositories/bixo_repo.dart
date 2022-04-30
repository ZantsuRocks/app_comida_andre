import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

import '../Models/bixo.dart';

class BixoRepo {
  // static String startPath = 'http://192.168.4.1';
  static String startPath = 'http://192.168.0.10/api/v1/';
  static final Uri _urlGet = Uri.parse('${startPath}get');
  static final Uri _urlPost = Uri.parse('${startPath}post');
  static final Uri _urlImageGet = Uri.parse('${startPath}image-get');
  static final Uri _urlImagePost = Uri.parse('${startPath}image-post');

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

  static Future<Bixo> sendBixoImage(Uint8List imageToSend, {Bixo? bixoToReplace}) async {
    Response response = await post(
      _urlImagePost,
      headers: {'Content-Type': 'application/octet-stream'},
      body: imageToSend,
    );

    if (response.statusCode == 200) {
      if (bixoToReplace != null) {
        bixoToReplace.fotoAsBytes = imageToSend;
        return bixoToReplace;
      }
      return Bixo()..fotoAsBytes = imageToSend;
    } else {
      throw (Exception('Response Code was: ${response.statusCode}'));
    }
  }
}
