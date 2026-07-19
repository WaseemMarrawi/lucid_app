
import 'package:flutter/material.dart';
import 'package:restaurants_menu/features/product/presentation/widget/product_details_sliver_app_bar_widget.dart';
import 'package:restaurants_menu/features/product/presentation/widget/product_gellery_widget.dart';

import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/extensions/src/description_extensions.dart';
import '../../../../common/models/product_model.dart';
import '../bloc/product_bloc.dart';

class ProductDetailsSliverAppBarWidget extends StatefulWidget {
  final ScrollController scrollController;
  final ProductBloc productBloc;
  final ProductModel productModel;

  const ProductDetailsSliverAppBarWidget({
    super.key,
    required this.scrollController,
    required this.productBloc,
    required this.productModel,
  });

  @override
  State<ProductDetailsSliverAppBarWidget> createState() =>
      _ProductDetailsSliverAppBarWidgetState();
}

class _ProductDetailsSliverAppBarWidgetState
    extends State<ProductDetailsSliverAppBarWidget> {
  late final PageController _pageController;
  late final ValueNotifier<int> currentPage;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    currentPage = ValueNotifier(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    currentPage.dispose();
    super.dispose();
  }

  String _productName(BuildContext context) {
    return widget.productModel.name.getName();
  }

  List<String> get _gallery => widget.productModel.media?.gallery ?? [];

  double _expandedHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return (width * .55).clamp(280.0, 500.0);
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = _expandedHeight(context);

    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        final offset = widget.scrollController.hasClients
            ? widget.scrollController.offset
            : 0.0;

        final progress = (offset / (expandedHeight - kToolbarHeight)).clamp(
          0.0,
          1.0,
        );

        final animation = ProductDetailsHeaderAnimation(progress: progress);

        return SliverAppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          expandedHeight: expandedHeight,
          pinned: true,


          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 1,
          centerTitle: false,
          leadingWidth: 0,
          leading: const SizedBox(),

          title: Transform.translate(
            offset: animation.appBarTitleOffset,
            child: Opacity(
              opacity: animation.appBarTitleOpacity,
              child: Row(
                children: [
                  IconButton(
                    onPressed: context.pop,
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: context.textColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _productName(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.headlineSmall(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),


          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,

            background: ProductGalleryWidget(
              gallery: _gallery,
              productId: widget.productModel.id!,
              video: widget.productModel.media?.productVideo,
            ),
          ),
        );
      },
    );
  }
}