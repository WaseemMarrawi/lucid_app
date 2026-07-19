
class MediaModel {
  final String? image;
  final String? productVideo;
  final List<String>? gallery;


  MediaModel({
    this.image,
    this.gallery,
    this.productVideo,

  });

  MediaModel copyWith({
    String? image,
    String? productVideo,
    List<String>? gallery,

  }) {
    return MediaModel(
      image: image ?? this.image,
      productVideo: productVideo ?? this.productVideo,
      gallery: gallery ?? this.gallery,

    );
  }

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      image: json["image"],
      productVideo: json["product_video"],
      gallery: json["gallery"] == null
          ? []
          : List<String>.from(json["gallery"]),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "product_video": productVideo,
      "gallery": gallery,

    };
  }
}
