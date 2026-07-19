class ImageModel {
  final int? id;
  final String? fileName;
  final String? url;
  final int? size;
  final String? mimeType;
  final DateTime? createdAt;

  ImageModel({
    this.id,
    this.fileName,
    this.url,
    this.size,
    this.mimeType,
    this.createdAt,
  });

  ImageModel copyWith({
    int? id,
    String? fileName,
    String? url,
    int? size,
    String? mimeType,
    DateTime? createdAt,
  }) =>
      ImageModel(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        url: url ?? this.url,
        size: size ?? this.size,
        mimeType: mimeType ?? this.mimeType,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    fileName: json["fileName"],
    url: json["url"],
    size: json["size"],
    mimeType: json["mimeType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileName": fileName,
    "url": url,
    "size": size,
    "mimeType": mimeType,
    "createdAt": createdAt?.toIso8601String(),
  };
}