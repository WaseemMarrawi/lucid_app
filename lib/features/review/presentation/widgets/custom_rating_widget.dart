import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../common/extensions/src/context_extensions.dart';

class CustomRatingWidget extends StatelessWidget {
  final ValueNotifier<double> rate;

  const CustomRatingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: rate,
      builder: (context, currentRate, _) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: SizedBox(
            // تحديد ارتفاع وعرض مناسبين يمنعان ضرب الشكل في الوضع العرضي
            height: 35.0,
            child: RatingBar(
              initialRating: currentRate,
              minRating: 0.0,
              maxRating: 5.0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 35.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              glow: false,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star_rounded,
                  color: context.primarySwatch,
                ),
                half: Directionality.of(context) == TextDirection.rtl
                    ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                  child: Icon(
                    Icons.star_half_rounded,
                    color: context.primarySwatch,
                  ),
                )
                    : Icon(
                  Icons.star_half_rounded,
                  color: context.primarySwatch,
                ),
                empty: Icon(
                  Icons.star_outline_rounded,
                  color: context.textColor,
                ),
              ),
              onRatingUpdate: (double rating) {
                rate.value = rating;
                print('Rating: $rating');
              },
            ),
          ),
        );
      },
    );
  }
}