// import 'package:dossan/common/design/src/widgets/animation_widget/animated_scale_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../common/design/src/widgets/shimmer_widget.dart';
// import '../../../../../common/extensions/src/context_extensions.dart';
// import '../../../../category/presentation/bloc/category_bloc.dart';
// import '../brand_widget.dart';
// import '../home loading widgets/home_brand_loading_widget.dart';
//
// class HomeBrandsStatusWidget extends StatelessWidget {
//   final CategoryBloc categoryBloc;
//
//   const HomeBrandsStatusWidget({super.key, required this.categoryBloc});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: BlocBuilder<CategoryBloc, CategoryState>(
//         bloc: categoryBloc,
//         builder: (context, state) {
//           return state.getAllBrands.builder(
//             successWidet: () => SizedBox(
//               height: 40,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 26,vertical: 0),
//                 clipBehavior: Clip.none,
//                 itemCount: state.getAllBrands.listLength(1),
//                 itemBuilder: (_, index) {
//                   if (state.getAllBrands.length <= index) {
//                     if (state.getAllBrands.length == index) {
//                       categoryBloc.add(GetAllBrandEvent());
//                     }
//                     return ShimmerWidget(
//                       borderRadius: BorderRadius.circular(12),
//                       width: context.width * .2,
//                       height: 40,
//                     );
//                   }
//
//                   return AnimatedScaleWidget(
//                     child: BrandWidget(
//                       brand: state.getAllBrands[index],
//                       categoryBloc: categoryBloc,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             onTapRetry: () =>
//                 categoryBloc.add(GetAllBrandEvent(isReload: true)),
//             loadingWidget: HomeBrandLoadingWidget(),
//           );
//         },
//       ),
//     );
//   }
// }
