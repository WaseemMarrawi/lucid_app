import 'package:flutter/material.dart';

import '../../../../../common/design/src/widgets/shimmer_widget.dart';
import '../../../../../common/extensions/src/context_extensions.dart';

class HomeBrandLoadingWidget extends StatelessWidget {
  const HomeBrandLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:40,
      child:Row(
        children: [
          SizedBox(width: context.width * .05),
          Expanded(
            child: ShimmerWidget(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: context.width * .05),
          Expanded(
            child: ShimmerWidget(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: context.width * .05),
          Expanded(
            child: ShimmerWidget(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: context.width * .05),
        ],
      ),
    );
  }
}
