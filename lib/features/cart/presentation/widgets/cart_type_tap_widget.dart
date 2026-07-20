import 'package:flutter/material.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';

class CartTypeTapWidget extends StatelessWidget {
  final ServiceCartType selectedIndex;
  final CartBloc cartBloc;

  const CartTypeTapWidget({
    super.key,
    required this.selectedIndex,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.primarySwatch;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: context.isMobile
            ? context.width
            : context.isDesktop
            ? context.width * .5
            : context.width * .7,
        height: 52,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          // color: context.cardColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                /// Sliding Indicator
                AnimatedAlign(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  alignment: selectedIndex.type == ServiceType.internal
                      ? AlignmentDirectional.centerStart
                      : AlignmentDirectional.centerEnd,
                  child: Container(
                    width: constraints.maxWidth / 2,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                /// Tabs
                Row(
                  children: [
                    Expanded(
                      child: _TabItem(
                        title: LocaleKeys.homeDineIn.tr(),
                        selected:
                        selectedIndex.type == ServiceType.internal,
                        onTap: () {
                          cartBloc.add(
                            ChangeSelectedServices(
                              serviceCartType: ServiceCartType(
                                name: LocaleKeys.homeDineIn.tr(),
                                type: ServiceType.internal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: _TabItem(
                        title: LocaleKeys.homeTakeaway.tr(),
                        selected:
                        selectedIndex.type == ServiceType.external,
                        onTap: () {
                          cartBloc.add(
                            ChangeSelectedServices(
                              serviceCartType: ServiceCartType(
                                name: LocaleKeys.homeTakeaway.tr(),
                                type: ServiceType.external,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: selected
                  ? Colors.white
                  : context.primarySwatch,
            ),
            child: Text(title,style: context.bodyLarge(
              color: selected
                  ? Colors.white
                  : context.primarySwatch,

            ),),
          ),
        ),
      ),
    );
  }
}

class ServiceCartType {
  final String name;
  final ServiceType type;

  ServiceCartType({
    required this.name,
    required this.type,
  });
}

enum ServiceType {
  internal,
  external,
}