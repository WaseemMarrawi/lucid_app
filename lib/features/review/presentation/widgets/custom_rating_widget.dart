import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/src/context_extensions.dart';

class CustomRatingWidget extends StatelessWidget {
  ValueNotifier<double> rate;

  CustomRatingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return AnimatedRatingStars(
      initialRating: rate.value,
      minRating: 0.0,
      maxRating: 5.0,

      filledColor: context.primarySwatch,
      emptyColor: context.textColor,
      onChanged: (double rating) {
        rate.value = rating;
        // Handle the rating change here
        print('Rating: $rating');
      },
      displayRatingValue: true,
      interactiveTooltips: true,
      customFilledIcon: Icons.star_rounded,
      customHalfFilledIcon: Icons.star_half_rounded,
      customEmptyIcon: Icons.star_outline_rounded,
      starSize: 35,
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,



      readOnly: false,



    );
  }
}

// class FlippableStar extends StatelessWidget {
//   final Widget child;
//
//
//   const FlippableStar({
//     super.key,
//     required this.child,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       alignment: Alignment.center,
//       transform: Matrix4.identity()
//         ..rotateY( 3.1415926535897932 ),
//       child: child,
//     );
//   }
// }
