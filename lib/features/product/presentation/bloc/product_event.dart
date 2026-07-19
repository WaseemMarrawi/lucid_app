part of 'product_bloc.dart';



abstract class ProductEvent {}

class GetAllProductEvent extends ProductEvent {}
class GetProductImagesEvent extends ProductEvent{}

class InitSelectedSuperCategoryEvent extends ProductEvent{}


class SelectSuperCategoryEvent extends ProductEvent{
  final SuperCategoryModel? params;

  SelectSuperCategoryEvent({required this.params});
}

class SelectCategoryEvent extends ProductEvent{
  final SuperCategoryModel? params;

  SelectCategoryEvent({required this.params});
}



// class GetAccessoryDetailsEvent extends AccessoryEvent {
//   final int id;
//
//   GetAccessoryDetailsEvent({required this.id});
// }
//
// class InitAccessoryEvent extends AccessoryEvent {}
// class InitSearchAccessoryEvent extends AccessoryEvent {}
//
// class SelectAccessoryCategoryEvent extends AccessoryEvent {
//   final String? category;
//
//   SelectAccessoryCategoryEvent({required this.category});
// }
//
// class SearchAccessoriesEvent extends AccessoryEvent with EventWithReload {
//   @override
//   final bool isReload;
//
//   final GetAllAccessoriesParams params;
//
//   SearchAccessoriesEvent({required this.params, this.isReload = false});
// }
