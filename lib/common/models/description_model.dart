class DescriptionModel {
  final String? en;
  final String? ar;
  final String? ku;

  DescriptionModel({this.en, this.ar, this.ku});

  DescriptionModel copyWith({String? en, String? ar, String? ku}) =>
      DescriptionModel(en: en ?? this.en, ku: ku ?? this.ku, ar: ar ?? this.ar);

  factory DescriptionModel.fromJson(Map<String, dynamic> json) =>
      DescriptionModel(en: json["en"], ku: json["ku"], ar: json["ar"]);

  Map<String, dynamic> toJson() => {"en": en, "ku": ku, "ar": ar};
}
