class IngredientsModel {
  final List<String>? ar;
  final List<String>? en;
  final List<String>? ku;

  IngredientsModel({this.ar, this.en,this.ku});

  factory IngredientsModel.fromJson(Map<String, dynamic> map) {
    return IngredientsModel(
      ar: map['ar'] == null ? [] : List<String>.from(map['ar']),
      en: map['en'] == null ? [] : List<String>.from(map['en']),
      ku: map['ku'] == null ? [] : List<String>.from(map['ku']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
      'ku': ku,
    };
  }
}