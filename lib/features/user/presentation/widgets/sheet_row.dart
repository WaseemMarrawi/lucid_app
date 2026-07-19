import 'package:flutter/material.dart';

import '../../../../common/extensions/src/context_extensions.dart';

class SheetRow extends StatelessWidget {
  final String name;
  final IconData icon;
  final GestureTapCallback? onTap;

  const SheetRow({super.key, required this.name, required this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: context.width * .01,
            ),
            Icon(
              icon,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
