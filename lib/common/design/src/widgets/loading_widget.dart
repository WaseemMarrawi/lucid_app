import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../extensions/src/context_extensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 225,
        child: Stack(
          alignment: Alignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}


class LoadingItemWidget extends StatelessWidget {
  const LoadingItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.height * .25,
        child: Stack(
          alignment: Alignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}


//
// class AppLoadingIndicator extends StatelessWidget {
//   const AppLoadingIndicator({super.key, this.size, this.color});
//   final double? size;
//   final Color? color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: SpinKitHourGlass(
//           color: color ?? context.theme.primaryColor,
//           size: size ?? 50,
//         ));
//   }
// }

