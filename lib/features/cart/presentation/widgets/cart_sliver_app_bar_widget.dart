
import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';

import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/theme/const.dart';
import '../../../../common/design/src/widgets/auto_scroll_text_widget.dart';
import '../../../../common/design/src/widgets/cach_network_image.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/app_varibles.dart';
import '../../../../common/helper/src/locale_keys.dart';

class CartSliverAppBarWidget extends StatelessWidget {
  const CartSliverAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
      pinned: true,
      floating: false,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppVariables.user?.restaurant?.media?.logo!= null?
          CacheNetworkImage(imageUrl:
          AppVariables.user!.restaurant!.media!.logo!,
            width: 40,
            height: 40,
          )
              :
          Assets.images.png.logo.image(width: 40, color: context.textColor),
          Space.hS3,

          Expanded(
            child: AutoScrollTextWidget(
              width: context.width,

              text:
              AppVariables.user?.restaurant?.nameTranslations?.getName(
                emptyText: "Lucid"
              )??
              'Lucid'
              ,

              style: context.headlineSmall(
                fontSize: 22,
                color: context.textColor,
              ),
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: context.dividerColor, // لون الخط
        ),
      ),
    );
  }
}
