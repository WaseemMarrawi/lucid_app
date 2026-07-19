import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/core/di/injection.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/home_widgets/home_app_bar_widget.dart';
import 'package:restaurants_menu/features/product/presentation/bloc/product_bloc.dart';
import 'package:restaurants_menu/router/app_router.dart';
import '../../../../common/design/src/theme/theme/theme_collection.dart';
import '../../../../common/extensions/src/context_extensions.dart';
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

  final Map<int, GlobalKey> categoryKeys = {};

  Future<void> _scrollToCategory(int id) async {
    final key = categoryKeys[id];

    if (key?.currentContext == null) return;

    await Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0,
    );
  }

  @override
  void initState() {
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

    super.initState();
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 16)),

                  SuperCategoryStatusWidget(productBloc: productBloc),

                  CategoryStatusWidget(productBloc: productBloc),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        HomeProductGridStatusWidget(
                          productBloc: productBloc,
                          cartBloc: cartBloc,
                          runAddToCartAnimation: runAddToCartAnimation,
                          animationReady: animationReady,
                          categoryKeys: categoryKeys,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(RouteName.message);
          },
          child: Icon(Icons.chat_outlined, color: context.cardColor),
        ),
      ),
    );
  }
}

class BrandModel {
  final int id;
  final String nameEn;
  final String nameAr;

  BrandModel({required this.id, required this.nameEn, required this.nameAr});
}
