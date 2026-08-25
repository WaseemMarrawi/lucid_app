import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import '../../../../../common/design/src/theme/assets.gen.dart';
import '../../../../../common/design/src/theme/const.dart';
import '../../../../../common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import '../../../../../common/extensions/src/context_extensions.dart';
import '../../../../../common/helper/helper.dart';
import '../../../../../common/models/super_category_model.dart';
import '../../../../product/presentation/bloc/product_bloc.dart';

class SuperCategoryWidget extends StatelessWidget {
  final SuperCategoryModel superCategoryModel;
  final ProductBloc productBloc;

  const SuperCategoryWidget({
    super.key,
    required this.superCategoryModel,
    required this.productBloc,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleWidget(
      child: Padding(
        padding:  EdgeInsetsDirectional.only(end:8),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            if (productBloc.state.selectedSuperCategory?.id ==
                superCategoryModel.id) {
              // productBloc.add(SelectSuperCategoryEvent(params: null));
            } else {
              productBloc.add(
                SelectSuperCategoryEvent(params: superCategoryModel),
              );
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            decoration: BoxDecoration(
              color:
                  productBloc.state.selectedSuperCategory?.id !=
                      superCategoryModel.id
                  ? Colors.transparent
                  : context.primarySwatch,
              borderRadius: BorderRadius.circular(24),
              // border: Border.all(
              //   color: context.primarySwatch
              // ),

            ),
            child: Text(
              superCategoryModel.name.getName(),
              style:
                  productBloc.state.selectedSuperCategory?.id ==
                      superCategoryModel.id
                  ? context.headlineMedium(color: context.cardColor,fontSize: 15)
                  : context.headlineMedium(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final SuperCategoryModel categoryModel;
  final ProductBloc productBloc;

  const CategoryWidget({
    super.key,
    required this.categoryModel,
    required this.productBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 12),
      child: AnimatedScaleWidget(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {


            if (productBloc.state.selectedCategory?.id ==
                categoryModel.id) {
              // productBloc.add(SelectCategoryEvent(params: null));

            } else {
              productBloc.add(SelectCategoryEvent(params: categoryModel));

            }

          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              // color: context.cardColor,
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: context.dividerColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.primarySwatch),
                    color:
                        productBloc.state.selectedCategory?.id ==
                            categoryModel.id
                        ? context.primarySwatch
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(10),
                  child:
                  categoryModel.media?.image==null?
                  Assets.images.png.logo.image(
                    color:
                    productBloc.state.selectedCategory?.id ==
                        categoryModel.id
                        ? context.cardColor
                        : context.textColor,
                    width: 24,
                    height: 24,
                  )
                      :
                  CacheNetworkImageLocale2(imageUrl: categoryModel.media!.image!,

                    width: 24,
                    height: 24,
                    color:
                    productBloc.state.selectedCategory?.id ==
                        categoryModel.id
                        ? context.cardColor
                        : context.primarySwatch,





        )

                ),
                Space.vS2,
                Text(
                  categoryModel.name.getName(),
                  style:
                      productBloc.state.selectedCategory?.id == categoryModel.id
                      ? context.bodyMedium(
                          color: context.primarySwatch,
                          fontSize: 15,
                        )
                      : context.bodyLarge(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
