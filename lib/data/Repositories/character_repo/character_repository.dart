import 'package:simpson_character_viewer/data/Providers/character_provider/CharacterProvider.dart';

class CharacterRepository {
  final CharacterProvider apiClient;
  CharacterRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<dynamic>> getCharacters() async {
    return await apiClient.getCharacters();
  }
}
