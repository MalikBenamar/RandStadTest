import 'package:simpson_character_viewer/data/Models/CharacterIconModel.dart';

class CharacterModel {
  String? firstURL;
  String? result;
  String? text;
  CharacterIconModel? icon;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> iconMap = json["Icon"] as Map<String, dynamic>;
    CharacterIconModel icon1;
    icon1 = (CharacterIconModel.fromJson(iconMap));

    return CharacterModel(
      firstURL: json['FirstURL'] ?? "",
      result: json['Result'] ?? "",
      text: json['Text'] ?? "",
      icon: icon1,
    );
  }

  CharacterModel({
    this.firstURL,
    this.result,
    this.text,
    this.icon,
  });

  Map<String, dynamic> toJson() => {
        "FirstURL": firstURL,
        "Result": result,
        "Text": text,
        "Icon": icon!.toJson(),
      };
}
