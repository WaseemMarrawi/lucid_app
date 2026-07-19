// import 'package:flutter/material.dart';
//
// import '../../../../../common/design/src/theme/assets.gen.dart';
// import '../../../../../common/design/src/theme/const.dart';
// import '../../../../../common/design/src/widgets/svg_asset.dart';
// import '../../../../../common/extensions/src/context_extensions.dart';
// import '../../../../category/presentation/bloc/category_bloc.dart';
// import '../../../../product/presentation/bloc/product_bloc.dart';
//
// class HomeErrorWidget extends StatelessWidget {
//   final ProductBloc productBloc;
//   final CategoryBloc categoryBloc;
//
//   const HomeErrorWidget({
//     super.key,
//     required this.productBloc,
//     required this.categoryBloc,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         categoryBloc.add(GetAllBrandEvent(isReload: true));
//         productBloc.add(GetAllProductEvent(isReload: true));
//       },
//       child: CustomScrollView(
//
//         slivers: [
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//
//               child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgAsset(Assets.images.svg.error.errorImage, height: 150),
//                   Space.vM4,
//                   Text(
//                     'Something Went Wrong',
//                     style: context.bodyLarge(
//                       fontSize: 24,
//                       color: context.errorColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Space.vS3,
//                   Text(
//                     'We couldn’t load this information. Please try again later.',
//                     style: context.bodyMedium(
//                       fontSize: 18,
//                       color: context.hintColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Space.vL3,
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         categoryBloc.add(GetAllBrandEvent(isReload: true));
//                         productBloc.add(GetAllProductEvent(isReload: true));
//                       },
//                       child: const Text("Reload"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
