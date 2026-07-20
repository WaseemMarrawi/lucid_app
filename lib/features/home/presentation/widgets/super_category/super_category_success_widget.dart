import 'package:flutter/material.dart';
import 'package:restaurants_menu/features/home/presentation/widgets/super_category/super_category_widget.dart';
import 'package:restaurants_menu/features/product/presentation/bloc/product_bloc.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/models/super_category_model.dart';

class SuperCategorySuccessWidget extends StatelessWidget {
  final ProductBloc productBloc;
  final List<SuperCategoryModel> superCategoryList;

  const SuperCategorySuccessWidget({super.key, required this.productBloc, required this.superCategoryList});


  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: AlignmentDirectional.centerStart,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Container(
          height: 60,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            // color: context.cardColor,
            borderRadius: BorderRadius.circular(24),
            // border: Border.all(color: context.dividerColor),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              superCategoryList.length,
                  (index) {
                return SuperCategoryWidget(
                  productBloc: productBloc,
                  superCategoryModel: superCategoryList[index],
                );
              },
            ),
          )
        ),
      ),
    );
  }
}



class CategorySuccessWidget extends StatelessWidget {
  final ProductBloc productBloc;
  final List<SuperCategoryModel> superCategoryList;

  const CategorySuccessWidget({super.key, required this.productBloc, required this.superCategoryList});


  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: AlignmentDirectional.centerStart,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: Container(
            height: 120,
            padding: EdgeInsets.all(8),


            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                superCategoryList.length,
                    (index) {
                  return CategoryWidget(
                    productBloc: productBloc,
                    categoryModel: superCategoryList[index],
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}
