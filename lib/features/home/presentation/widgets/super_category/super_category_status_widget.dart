import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/super_category/super_category_success_widget.dart';
import '../../../../../common/design/src/widgets/shimmer_widget.dart';
import '../../../../product/presentation/bloc/product_bloc.dart';

class SuperCategoryStatusWidget extends StatelessWidget {
  final ProductBloc productBloc;

  const SuperCategoryStatusWidget({super.key, required this.productBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: productBloc,
      builder: (context, state) {
        return state.getAllProductData.builder(
          onTapRetry: () {
            productBloc.add(GetAllProductEvent());
          },

          loadingWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ShimmerWidget(
              height: 60,
              padding: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(24),
            ),
          ),

          onSuccess: (getAllProduct) {
            final superCategories =
                getAllProduct?.data?.superCategories ?? [];

            if (superCategories.isEmpty) {
              return const SizedBox();
            }

            return SuperCategorySuccessWidget(
              productBloc: productBloc,
              superCategoryList: superCategories,
            );
          },
          failedWidget: SizedBox(),
        );
      },
    );
  }
}

class CategoryStatusWidget extends StatelessWidget {
  final ProductBloc productBloc;

  const CategoryStatusWidget({super.key, required this.productBloc});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProductBloc,ProductState>(
        bloc: productBloc,
        builder: (context,state){

      return  state.getAllProductData.builder(


        loadingWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ShimmerWidget(
            height: 60,
            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(24),
          ),
        ),

        onSuccess: (getAllProduct) {



          if (state.selectedSuperCategory==null||state.selectedSuperCategory!.categories!.isEmpty) {
            return const SizedBox();
          }else{
            return CategorySuccessWidget(
              productBloc: productBloc,
              superCategoryList: state.selectedSuperCategory!.categories!,
            );
          }


        },
        failedWidget: SizedBox(),
      );
    });
  }
}
