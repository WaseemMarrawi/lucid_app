import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/design/src/widgets/auto_scroll_text_widget.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:restaurants_menu/features/cart/presentation/pages/cart_screen.dart';

import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../router/app_router.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final CartBloc cartBloc;
 final GlobalKey<CartIconKey> cartKey;

  const HomeAppBarWidget({super.key, required this.cartBloc, required this.cartKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        return AppBar(
          // pinned: true,
          // floating: false,
          backgroundColor: context.cardColor,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: context.textColor,
            ),
          ),
          title:
          AppVariables.user?.restaurant?.media?.logo!= null?
          CacheNetworkImage(imageUrl:
          AppVariables.user!.restaurant!.media!.logo!,
            height:60,
            width: 60,
          )
              :
          Assets.images.png.logo.image(width: 50, color: context.textColor),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     AppVariables.user?.restaurant?.media?.logo!= null?
          //         CacheNetworkImage(imageUrl:
          //         AppVariables.user!.restaurant!.media!.logo!,
          //           height: 40,
          //           width: 40,
          //         )
          //         :
          //     Assets.images.png.logo.image(width: 25, color: context.textColor),
          //     Space.hS3,
          //
          //     SizedBox(
          //       width: context.width*.5,
          //       child: SmartMarqueeText(
          //
          //         text:
          //         AppVariables.user?.restaurant?.nameTranslations?.getName(
          //           emptyText:"Lucid"
          //         ) ??
          //            "Lucid",
          //
          //         style: context.headlineSmall(
          //           fontSize: 22,
          //           color: context.textColor,
          //         ),
          //       ),
          //     ),
          //
          //   ],
          // ),
          actions: [
            AddToCartIcon(
              key: cartKey,
              icon: InkWell(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: state.cartList.isNotEmpty
                        ? context.primarySwatch.withOpacity(.1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    clipBehavior: Clip.none,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 25,
                          end: state.cartList.isNotEmpty ? 30 : 25,
                        ),
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        builder: (context, size, child) {
                          return SvgAsset(
                            Assets.images.svg.home.shopping,
                            height: size,
                            color: context.textColor,
                          );
                        },
                      ),
                      if (state.cartList.isNotEmpty) ...[
                        Positioned(
                          top: -7,
                          right: -7,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.primarySwatch,
                            ),
                            child: Text(
                              state.cartList.length.toString(),
                              style: context.bodyLarge(
                                color: context.cardColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                onTap: () {
                  context.pushNamed(
                    RouteName.cart,
                    arguments: CartScreenParams(cartBloc: cartBloc),
                  );
                },
              ),
              badgeOptions: BadgeOptions(
                active: false
              ),
            ),
          ],
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(1),
          //   child: Divider(
          //     height: 1,
          //     thickness: 1,
          //     color: context.primarySwatch, // لون الخط
          //   ),
          // ),
        );
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
