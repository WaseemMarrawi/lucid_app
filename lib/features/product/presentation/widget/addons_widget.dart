

  import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import 'package:restaurants_menu/common/extensions/src/description_extensions.dart';
import 'package:restaurants_menu/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../common/models/addon_model.dart';
import '../../../../common/models/product_model.dart';

class AddonsWidget extends StatefulWidget {
    final CartBloc cartBloc;
    final AddonModel addonModel;
    final ProductModel productModel;
    final List<AddonModel> localeSelectedAddons;

  const AddonsWidget({super.key, required this.cartBloc, required this.addonModel, required this.productModel, required this.localeSelectedAddons});



  @override
  State<AddonsWidget> createState() => _AddonsWidgetState();
}

class _AddonsWidgetState extends State<AddonsWidget> {

 late ValueNotifier<bool> isChecked;
 @override
  void initState() {
   isChecked = ValueNotifier<bool>(
     widget.cartBloc.state.cartList.any(
           (cartItem) =>
       cartItem.id == widget.productModel.id &&
           (cartItem.selectedAddons?.any(
                 (addon) => addon.id == widget.addonModel.id,
           ) ??
               false),
     ),
   );
   


   // TODO: implement initState
    super.initState();
  }

    @override
    Widget build(BuildContext context) {
      return AnimatedScaleWidget(
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsetsDirectional.only(end: 18),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: .circular(20),
            border: Border.all(color: context.dividerColor),
          ),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: isChecked,
                builder: (context, value, child) {
                  return Checkbox(value: value, onChanged: (value) {
                    isChecked.value=value!;
                    if(value){
        
                  if(widget.cartBloc.state.cartList.any((e)=>e.id==widget.productModel.id)){
                    final cartItem = widget.cartBloc.state.cartList
                        .where((e) => e.id == widget.productModel.id)
                        .firstOrNull;
        
                    final list = List<AddonModel>.from(
                      cartItem?.selectedAddons ?? [],
                    )..add(widget.addonModel);
                   widget.cartBloc.add(
                        EditCartEvent(
                            params: widget.productModel.copyWith(
                                selectedAddons: list
                            )));
        
        
                  }else{
                    widget.localeSelectedAddons.add(widget.addonModel);
        
                  }
        
        
                    }else{
                      if(widget.cartBloc.state.cartList.any((e)=>e.id==widget.productModel.id)){
                        final cartItem = widget.cartBloc.state.cartList
                            .where((e) => e.id == widget.productModel.id)
                            .firstOrNull;
        
                        final list = List<AddonModel>.from(
                          cartItem?.selectedAddons ?? [],
                        )..removeWhere((e) => e.id == widget.addonModel.id);
                        widget.cartBloc.add(
                            EditCartEvent(
                                params: widget.productModel.copyWith(
                                    selectedAddons: list
                                )));
        
        
                      }else{
                        widget.localeSelectedAddons.remove(widget.addonModel);
        
                      }
                    }
        
        
                  });
                }
              ),
        
              Text(
                widget.addonModel.name.getName(),
                style: context.bodyMedium(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }
}
