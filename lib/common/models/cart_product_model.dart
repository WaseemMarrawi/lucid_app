// import 'package:restaurants_menu/common/models/description_model.dart';
// import 'package:restaurants_menu/common/models/product_model.dart';
//
// class CartProductModel {
//   final int? id;
//   final DescriptionModel? name;
//   final int? count;
//   final String? image;
//   final String? note;
//   final List<AddonModel>? addons;
//   final String? internalPrice;
//   final String? externalPrice;
//
//   CartProductModel({
//     this.id,
//     this.name,
//     this.count,
//     this.addons,
//     this.note,
//     this.internalPrice,
//     this.externalPrice,
//     this.image,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'dish_id': id,
//       'quantity': count,
//       'notes': note,
//       'name': name,
//       'count': count,
//       'addons': addons == null
//           ? []
//           : List<dynamic>.from(addons!.map((x) => x.toJson())),
//       'externalPrice': externalPrice,
//       'internalPrice': internalPrice,
//       'image': image,
//     };
//   }
//
//   Map<String, dynamic> toApi() {
//     return {
//       'dish_id': id,
//       'quantity': count,
//       'notes': note,
//       'name': name?.toJson(),
//       'addons': addons == null
//           ? []
//           : List<dynamic>.from(addons!.map((x) => x.toApi())),
//     };
//   }
//
//   factory CartProductModel.fromJson(Map<String, dynamic> map) {
//     return CartProductModel(
//       id: map['id'] as int?,
//       name: DescriptionModel.fromJson(map['name']) as DescriptionModel?,
//       note: map['note'] as String?,
//       image: map['image'] as String?,
//       count: map['count'] as int? ?? 0,
//       internalPrice: map['internalPrice'] as String?,
//       externalPrice: map['externalPrice'] as String?,
//       addons: map["addons"] == null
//           ? []
//           : List<AddonModel>.from(
//               map["addons"]!.map((x) => AddonModel.fromJson(x)),
//             ),
//     );
//   }
//
//   CartProductModel copyWith({
//     int? id,
//     DescriptionModel? name,
//     String? image,
//     String? note,
//     int? count,
//     String? internalPrice,
//     String? externalPrice,
//     int? price,
//     List<AddonModel>? addons,
//   }) {
//     return CartProductModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       count: count ?? this.count,
//       addons: addons ?? this.addons,
//       externalPrice: externalPrice ?? this.externalPrice,
//       internalPrice: internalPrice ?? this.internalPrice,
//       image: image ?? this.image,
//       note: note ?? this.note,
//     );
//   }
// }
