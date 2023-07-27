class CharacterIconModel {
  String? height;
  String? width;
  String? url;

  CharacterIconModel({
    this.height,
    this.width,
    this.url,
  });

  factory CharacterIconModel.fromJson(Map<String, dynamic> json) =>
      CharacterIconModel(
        height: json['Height'] ?? "",
        width: json['Width'] ?? "",
        url: json['URL'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Height": height,
        "Width": width,
        "URL": url,
      };
}
