import 'package:flutter/material.dart';
import '../../../extensions/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      surfaceTintColor: context.scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class CustomMyAppBar extends StatelessWidget implements PreferredSizeWidget {
   CustomMyAppBar({
    super.key,
    required this.title,
    this.actions,
    required this.isBack,
    this.leading,
    this.fun
  });
  final String title;
  final List<Widget>? actions;
  final bool isBack;
  final Widget? leading;
  final VoidCallback? fun;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
            title ,
          style: context.labelLarge(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // leading:isBack?  GestureDetector(
        //   child: SvgAsset(
        //     AppVariables.checkLanguage(context) == 'ar'
        //         ? Assets.images.svg.rightArrow
        //         : Assets.images.svg.leftArrow,
        //     height: 10,
        //     width: 10,
        //   ),
        //   onTap:  fun?? ()=>context.pop(),
        // ):leading
        //
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
