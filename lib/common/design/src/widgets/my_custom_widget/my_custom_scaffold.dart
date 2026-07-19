import 'package:flutter/material.dart';

import '../../../../extensions/src/context_extensions.dart';

class MyCustomScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final double  top;
  final double  bottom;

  const MyCustomScaffold({super.key, required this.body, this.appBar,this.top=0,this.bottom=0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: context.statusBarHeight +top,
          bottom: context.navigationBarHeight+bottom,
          start: 16,
          end: 16,
        ),
        child: body,

      ),
    );
  }
}


class MyCustomBody extends StatelessWidget {
  final Widget widget;
  final AppBar? appBar;
  final double top;

  const MyCustomBody({super.key, required this.widget, this.appBar,this.top=0 });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.only(
          top: MediaQuery
              .of(context)
              .padding
              .top+top,
          start: 20,
          end: 20,
        ),
        child: widget,

    );
  }
}
