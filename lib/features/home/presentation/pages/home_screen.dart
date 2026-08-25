import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/core/di/injection.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/home_widgets/home_app_bar_widget.dart';
import 'package:restaurants_menu/features/product/presentation/bloc/product_bloc.dart';
import 'package:restaurants_menu/router/app_router.dart';

import '../../../../common/design/src/theme/theme/theme_collection.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../chat/presentation/widgets/home_voice_chat_widget.dart';
import '../widgets/home_widgets/home_product_grid_status_widget.dart';
import '../widgets/super_category/super_category_status_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductBloc productBloc;
  late final CartBloc cartBloc;
  final ValueNotifier<bool> animationReady = ValueNotifier(false);
  final cartKey = GlobalKey<CartIconKey>();
  Function(GlobalKey)? runAddToCartAnimation;

  // استخدام ItemScrollController الخاص بمكتبة scrollable_positioned_list
  final ItemScrollController itemScrollController = ItemScrollController();

  Future<void> _scrollToCategory(int categoryId) async {
    final list = productBloc.state.categoryProductList;
    if (list.isEmpty) return;

    // البحث عن الـ index الخاص بالقسم المختار
    final targetIndex = list.indexWhere((item) => item.$1.id == categoryId);

    if (targetIndex != -1 && itemScrollController.isAttached) {
      itemScrollController.scrollTo(
        index: targetIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    productBloc = getIt<ProductBloc>()
      ..add(GetAllProductEvent())
      ..add(InitSelectedSuperCategoryEvent());
    cartBloc = getIt<CartBloc>()..add(InitSelectedServices());

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ThemeCollection.lightTheme.cardColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor:
        ThemeCollection.lightTheme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (runAddToCartAnimation != null) {
        animationReady.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      createAddToCartAnimation: (fn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              runAddToCartAnimation = fn;
            });
            animationReady.value = true;
          }
        });
      },
      child: Scaffold(
        appBar: HomeAppBarWidget(cartBloc: cartBloc, cartKey: cartKey),
        body: BlocConsumer<ProductBloc, ProductState>(
          bloc: productBloc,
          listenWhen: (previous, current) =>
          previous.selectedCategory?.id != current.selectedCategory?.id,
          listener: (_, state) {
            final category = state.selectedCategory;
            if (category == null) return;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToCategory(category.id!);
            });
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(bottom: context.navigationBarHeight),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                  SuperCategoryStatusWidget(productBloc: productBloc),
                  Space.vM2,
                  CategoryStatusWidget(productBloc: productBloc),
                  Space.vM2,
                  Expanded(
                    child: HomeProductGridStatusWidget(
                      productBloc: productBloc,
                      cartBloc: cartBloc,
                      runAddToCartAnimation: runAddToCartAnimation,
                      animationReady: animationReady,
                      itemScrollController: itemScrollController,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton:
        AppVariables.user?.restaurant?.aiAudioChatEnabled == true
            ? HomeVoiceChatWidget()
            : AppVariables.user?.restaurant?.aiChatEnabled == true
            ? FloatingActionButton(
          onPressed: () {
            context.pushNamed(RouteName.message);
          },
          child: Assets.images.png.robot.image(
            height: 24,
            color: context.cardColor,
          ),
        )
            : null,
      ),
    );
  }
}

