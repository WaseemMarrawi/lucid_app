import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniversalLoadingIndicator extends StatelessWidget {
  final double size;

  const UniversalLoadingIndicator({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: size / 2,
        color: Colors.white,

      ),
    );
  }
}
