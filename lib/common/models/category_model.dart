// class CategoryModel {
//   final int id;
//   final String name;
//   final String icon;
//   final String createdAt;
//   final String updatedAt;
//
//   const CategoryModel({
//     required this.id,
//     required this.name,
//     required this.icon,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   CategoryModel copyWith({
//     int? id,
//     String? name,
//     String? icon,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CategoryModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       icon: icon ?? this.icon,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       icon: json['icon'] as String,
//       createdAt: json['created_at'] as String,
//       updatedAt: json['updated_at'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'icon': icon,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }