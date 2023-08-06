import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:simpson_character_viewer/Common/api_constants.dart';
import 'package:simpson_character_viewer/data/Models/CharacterModel.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:simpson_character_viewer/data/Providers/character_provider/CharacterProvider.dart';

void main() {
  group('CharacterProvider', () {
    late CharacterProvider characterProvider;
    late DioAdapter dioAdapter;
    final _dio = Dio();

    setUp(() {
      dioAdapter = DioAdapter(dio: _dio);
      final dio = _dio..httpClientAdapter = dioAdapter;
      characterProvider = CharacterProvider();
      characterProvider.httpClient = dio;
    });

    test('should fetch characters and return a list', () async {
      var route = ServerConstants.mainURI + ServerConstants.simpsonEndPoint;

      final mockResponse = {
        "RelatedTopics": [
          {
            "FirstURL": "https://duckduckgo.com/Apu_Nahasapeemapetilon",
            "Icon": {"Height": "", "URL": "/i/99b04638.png", "Width": ""},
            "Result": "",
            "Text": "Character 1"
          },
          {
            "FirstURL": "https://duckduckgo.com/Apu_Nahasapeemapetilon",
            "Icon": {"Height": "", "URL": "/i/99b04638.png", "Width": ""},
            "Result": "",
            "Text": "Character 2"
          },
        ]
      };

      dioAdapter.onGet(
        route,
        (request) => request.reply(200, jsonEncode(mockResponse)),
      );

      final result = await characterProvider.getCharacters();

      // Assertions
      expect(result, isA<List<dynamic>>());
      expect(result.length, 2);
      expect(result[0], isA<CharacterModel>());
      expect(result[0].text, "Character 1");
      expect(result[1].text, "Character 2");
    });

    test('should throw an exception when the response is not successful',
        () async {
      var route = ServerConstants.mainURI + ServerConstants.simpsonEndPoint;

      dioAdapter.onGet(
        route,
        (request) => request.reply(404, ''),
      );

      try {
        await characterProvider.getCharacters();
        // The test should fail if no exception is thrown
        fail('Exception not thrown');
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
