import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:simpson_character_viewer/Common/api_constants.dart';
import 'package:simpson_character_viewer/data/Models/CharacterModel.dart';

class CharacterProvider {
  dio.Dio httpClient = dio.Dio(dio.BaseOptions(
    baseUrl: ServerConstants.mainURI,
    responseType: dio.ResponseType.json,
  ));

  Future<List<dynamic>> getCharacters() async {
    List<CharacterModel> listCharacter = [];

    Uri uri =
        Uri.parse(ServerConstants.mainURI + ServerConstants.theWireEndPoint);

    dio.Response response = await httpClient.get(uri.toString());
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      List<dynamic> list = res["RelatedTopics"];

      listCharacter =
          list.map((model) => CharacterModel.fromJson(model)).toList();

      return listCharacter;
    } else {
      throw Exception('Failed to load Characters');
    }
  }
}
