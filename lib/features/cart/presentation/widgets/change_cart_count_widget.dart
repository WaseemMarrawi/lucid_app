// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:restaurants_menu/common/models/product_model.dart';
// import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
// import '../../../../common/extensions/src/color_extentions.dart';
// import '../../../../common/extensions/src/context_extensions.dart';
// import 'package:collection/collection.dart';
// class ChangeCartCountWidget extends StatelessWidget {
//   final ProductModel productModel;
//   final CartBloc cartBloc;
//
//   const ChangeCartCountWidget(
//       {super.key, required this.productModel, required this.cartBloc});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius:
//         BorderRadius.circular(32),
//         gradient: LinearGradient(
//           colors: [
//             context.primarySwatch.derivedColor,
//             context.primarySwatch,
//             context.primarySwatch,
//           ],
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//
//         ),
//
//         boxShadow: [
//           // الظل الأول (0px 2px 4px -2px #0000001A)
//           BoxShadow(
//             color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
//             offset: const Offset(0, 2),
//             blurRadius: 4,
//             spreadRadius: -2,
//           ),
//           // الظل الثاني (0px 4px 6px -1px #0000001A)
//           BoxShadow(
//             color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
//             offset: const Offset(0, 4),
//             blurRadius: 6,
//             spreadRadius: -1,
//           ),
//         ],
//
//       ),
//       padding: EdgeInsets.all(9),
//       child: Row(
//         children: [
//           InkWell(
//             onTap:
//             productModel
//                 .count! >=
//                 2
//                 ? () {
//               final val =
//                   productModel
//                       .count! -
//                       1;
//
//               cartBloc.add(
//                 EditCartEvent(
//                   params: productModel
//                       .copyWith(
//                     count:
//                     val,
//                   ),
//
//                   // AddToCartParams(
//                   //   productId: widget
//                   //       .cartModel
//                   //       .orderItemsProduct!
//                   //       .productId!,
//                   //   productCount: val,
//                   // ),
//                 ),
//               );
//             }
//                 : (){
//               cartBloc.add(
//                 DeleteFromCartEvent(
//                   id: productModel.id!,
//                 ),
//               );
//             },
//             child: Icon(
//               Icons.remove,
//               color: context.cardColor,
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding:
//             const EdgeInsets.symmetric(
//               horizontal: 12,
//             ),
//             child: Text(
//               productModel
//                   .count
//                   .toString(),
//               style: context
//                   .headlineSmall(
//                 color: context.cardColor,
//
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           InkWell(
//             child: Icon(
//               Icons.add_outlined,
//               color: context.cardColor,
//               size: 30,
//
//             ),
//             onTap: () {
//               final val =
//                   productModel
//                       .count! +
//                       1;
//
//               cartBloc.add(
//                 EditCartEvent(
//                   params: productModel
//                       .copyWith(
//                     count: val,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class ProductChangeCartCountWidget extends StatelessWidget {
//   final ProductModel productModel;
//   final CartBloc cartBloc;
//
//   const ProductChangeCartCountWidget(
//       {super.key, required this.productModel, required this.cartBloc});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc, CartState>(
//       bloc: cartBloc,
//       builder: (context, state) {
//         final result = state.cartList.firstWhereOrNull(
//               (e) => e.id == productModel.id,
//         );
//      return   result == null? SizedBox.shrink():
//
//          Container(
//           decoration: BoxDecoration(
//             borderRadius:
//             BorderRadius.circular(32),
//             gradient: LinearGradient(
//               colors: [
//                 context.primarySwatch.derivedColor,
//                 context.primarySwatch,
//                 context.primarySwatch,
//               ],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter,
//
//             ),
//             boxShadow: [
//               // الظل الأول (0px 2px 4px -2px #0000001A)
//               BoxShadow(
//                 color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
//                 offset: const Offset(0, 2),
//                 blurRadius: 4,
//                 spreadRadius: -2,
//               ),
//               // الظل الثاني (0px 4px 6px -1px #0000001A)
//               BoxShadow(
//                 color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
//                 offset: const Offset(0, 4),
//                 blurRadius: 6,
//                 spreadRadius: -1,
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: InkWell(
//                   onTap:
//                   result
//                       .count! >=
//                       2
//                       ? () {
//                     final val =
//                         result
//                             .count! -
//                             1;
//
//                     cartBloc.add(
//                       EditCartEvent(
//                         params: productModel
//                             .copyWith(
//                           count:
//                           val,
//                         ),
//
//                         // AddToCartParams(
//                         //   productId: widget
//                         //       .cartModel
//                         //       .orderItemsProduct!
//                         //       .productId!,
//                         //   productCount: val,
//                         // ),
//                       ),
//                     );
//                   }
//                       : (){
//                     cartBloc.add(
//                       DeleteFromCartEvent(
//                         id: productModel.id!,
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 6),
//
//                     child: Icon(
//                       Icons.remove,
//                       color: context.cardColor,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   result
//                       .count
//                       .toString(),
//                   style: context
//                       .bodyLarge(
//                     color: context.cardColor,
//                     fontSize: 16,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 6),
//
//
//                     child: Icon(
//                       Icons.add_outlined,
//                       color: context.cardColor,
//                       size: 20,
//                     ),
//                   ),
//                   onTap: () {
//                     if(result.count! <99){
//                       final val =
//                           result
//                               .count! +
//                               1;
//
//                       cartBloc.add(
//                         EditCartEvent(
//                           params: productModel
//                               .copyWith(
//                             count: val,
//                           ),
//                         ),
//                       );
//                     }
//
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/models/product_model.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../common/design/src/theme/const.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import 'package:collection/collection.dart';
class ChangeCartCountWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;

  const ChangeCartCountWidget(
      {super.key, required this.productModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            context.primarySwatch.derivedColor,
            context.primarySwatch,
            context.primarySwatch,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,

        ),

        boxShadow: [
          // الظل الأول (0px 2px 4px -2px #0000001A)
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
          // الظل الثاني (0px 4px 6px -1px #0000001A)
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
        ],

      ),
      padding: EdgeInsets.all(9),
      child: Row(
        children: [
          InkWell(
            onTap:
            productModel
                .count! >=
                2
                ? () {
              final val =
                  productModel
                      .count! -
                      1;

              cartBloc.add(
                EditCartEvent(
                  params: productModel
                      .copyWith(
                    count:
                    val,
                  ),

                  // AddToCartParams(
                  //   productId: widget
                  //       .cartModel
                  //       .orderItemsProduct!
                  //       .productId!,
                  //   productCount: val,
                  // ),
                ),
              );
            }
                : (){
              cartBloc.add(
                DeleteFromCartEvent(
                  id: productModel.id!,
                ),
              );
            },
            child: Icon(
              Icons.remove,
              color: context.cardColor,
              size: 30,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              productModel
                  .count
                  .toString(),
              style: context
                  .headlineSmall(
                color: context.cardColor,

                fontSize: 16,
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.add_outlined,
              color: context.cardColor,
              size: 30,

            ),
            onTap: () {
              final val =
                  productModel
                      .count! +
                      1;

              cartBloc.add(
                EditCartEvent(
                  params: productModel
                      .copyWith(
                    count: val,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class ProductChangeCartCountWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;

  const ProductChangeCartCountWidget(
      {super.key, required this.productModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        final result = state.cartList.firstWhereOrNull(
              (e) => e.id == productModel.id,
        );
        return   result == null? SizedBox.shrink():

        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [
                context.primarySwatch.derivedColor,
                context.primarySwatch,
                context.primarySwatch,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,

            ),
            boxShadow: [
              // الظل الأول (0px 2px 4px -2px #0000001A)
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
              // الظل الثاني (0px 4px 6px -1px #0000001A)
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.10), // #0000001A
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: .min,
            children: [
              InkWell(
                onTap:
                result
                    .count! >=
                    2
                    ? () {
                  final val =
                      result
                          .count! -
                          1;

                  cartBloc.add(
                    EditCartEvent(
                      params: productModel
                          .copyWith(
                        count:
                        val,
                      ),

                      // AddToCartParams(
                      //   productId: widget
                      //       .cartModel
                      //       .orderItemsProduct!
                      //       .productId!,
                      //   productCount: val,
                      // ),
                    ),
                  );
                }
                    : (){
                  cartBloc.add(
                    DeleteFromCartEvent(
                      id: productModel.id!,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6),

                  child: Icon(
                    Icons.remove,
                    color: context.cardColor,
                    size: 20,
                  ),
                ),
              ),
              Space.hS3,
              Text(
                result
                    .count
                    .toString(),
                style: context
                    .bodyLarge(
                  color: context.cardColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Space.hS3,
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6),


                  child: Icon(
                    Icons.add_outlined,
                    color: context.cardColor,
                    size: 20,
                  ),
                ),
                onTap: () {
                  if(result.count! <99){
                    final val =
                        result
                            .count! +
                            1;

                    cartBloc.add(
                      EditCartEvent(
                        params: productModel
                            .copyWith(
                          count: val,
                        ),
                      ),
                    );
                  }

                },
              ),
            ],
          ),
        );
      },
    );
  }
}
