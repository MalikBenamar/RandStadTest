import 'package:get/get.dart';
import 'package:simpson_character_viewer/data/Models/CharacterModel.dart';
import 'package:simpson_character_viewer/data/Providers/character_provider/CharacterProvider.dart';
import 'package:simpson_character_viewer/data/Repositories/character_repo/character_repository.dart';

class DataListViewerController extends GetxController {
  RxBool searchfocus = false.obs;
  RxBool isLoading = false.obs;
  Rx<CharacterModel?> selectedModel = Rx<CharacterModel?>(null);

  RxList<CharacterModel> characters = RxList<CharacterModel>();
  RxList<CharacterModel> currentCharacters = RxList<CharacterModel>();

  late CharacterRepository repo;
  @override
  void onInit() {
    // TODO: implement onInit

    repo = new CharacterRepository(apiClient: CharacterProvider());
    loadCharacters();
    super.onInit();
  }

  void updateSelectedModel(CharacterModel newValue) {
    selectedModel.value = newValue;
  }

  Future<void> loadCharacters() async {
    isLoading(true);
    var listCharacters = await repo.getCharacters();
    listCharacters.forEach((element) {
      characters.add(element);
    });
    currentCharacters.value = characters.value;

    isLoading(false);
  }

  void SearchCharacters(String searchText) {
    currentCharacters.value = characters.value;

    currentCharacters.value = currentCharacters
        .where((item) =>
            item.text!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
