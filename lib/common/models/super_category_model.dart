
import 'description_model.dart';

class SuperCategoryModel {
  final int? id;
  final DescriptionModel? name;
  final List<SuperCategoryModel>? categories;
  final Media? media;


  SuperCategoryModel({this.id, this.name, this.categories,this.media});

  SuperCategoryModel copyWith({
    int? id,
    DescriptionModel? name,
    List<SuperCategoryModel>? categories,
     Media? media

  }) => SuperCategoryModel(
    id: id ?? this.id,
    name: name ?? this.name,
    categories: categories ?? this.categories,
    media: media ?? this.media,
  );

  factory SuperCategoryModel.fromJson(Map<String, dynamic> json) =>
      SuperCategoryModel(
        id: json["id"],
        name: json["name"] == null ? null : DescriptionModel.fromJson(json["name"]),
          media: json["media"] == null ? null : Media.fromJson(json["media"]),
        categories:
          json["categories"] == null
              ? []
              : List<SuperCategoryModel>.from(
            json["categories"]!.map((x) => SuperCategoryModel.fromJson(x)),
          )
      );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name?.toJson(),
    "media": media?.toJson(),
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}
class Media {
  final String? image;

  Media({this.image});

  Media copyWith({
    String? image,
  }) {
    return Media(
      image: image ?? this.image,
    );
  }

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      image: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': image,
    };
  }
}


