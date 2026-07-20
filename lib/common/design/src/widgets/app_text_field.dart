import 'package:flutter/material.dart';
import '../../../extensions/src/context_extensions.dart';
import '../../design.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.enabled = true,
    this.controller,
    this.validator,
    this.width,
    this.height,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.labelText,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.isPadding = true,
    this.focus,
  });

  final bool enabled;
  final bool isPassword;
  final int maxLines;
  final int minLines;
  final String? hintText;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final TextInputType keyboardType;
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final Function(String text)? onChanged;
  final String? labelText;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isPadding;
  final FocusNode? focus;

  @override
  Widget build(BuildContext context) {
    final baseDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    return ValueListenableBuilder<bool>(
      valueListenable: showPassword,
      builder: (context, showPassowrdValue, _) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: isPadding == true ? context.height * .02 : 0,
            vertical: isPadding == true ? context.width * .04 : 0,
          ),
          width: double.infinity,
          child: TextFormField(
            focusNode: focus == null ? focus : null,
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines,
            minLines: minLines,
            enabled: enabled,
            cursorColor: context.primarySwatch,
            keyboardType: isPassword
                ? TextInputType.visiblePassword
                : keyboardType,
            obscureText: isPassword ? !showPassowrdValue : false,
            style: context.labelMedium(
              color: context.themeExt.palette.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: baseDecoration.copyWith(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: context.primarySwatch),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: context.primarySwatch),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 2, color: context.primarySwatch),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.primarySwatch),
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.all(PPadding.mainPadding * 1.5),
              fillColor: fillColor ?? Colors.white,
              filled: true,
              hintText: hintText,
              hintStyle: context.labelMedium(
                color: context.primarySwatch,
                fontSize: 14,
              ),
              labelStyle: context.labelMedium(
                color: context.primarySwatch,
                fontSize: 14,
              ),
              labelText: labelText,
              prefixIcon: prefixIcon == null
                  ? null
                  : SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(PPadding.mainPadding),
                        child: prefixIcon,
                      ),
                    ),
              suffixIcon:
                  suffixIcon ??
                  (isPassword
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Space.hS2,
                            GestureDetector(
                              onTap: () =>
                                  showPassword.value = !showPassowrdValue,
                              child: SizedBox(
                                width: 65,
                                height: 25,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  size: 20,
                                  color: showPassowrdValue
                                      ? context.primarySwatch
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      : null),
              suffixIconConstraints: const BoxConstraints(minWidth: 45),
            ),
          ),
        );
      },
    );
  }
}

class MyAppTextField extends StatelessWidget {
  MyAppTextField({
    super.key,
    this.hintText,
    this.textInputAction,
    this.isPassword = false,
    this.enabled = true,
    this.controller,
    this.validator,
    this.width,
    this.height,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.labelText,
    this.fillColor,
    this.onSubmitted,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.isPadding = true,
    this.focus,
    this.isNumber = false,
  });

  final bool enabled;
  final bool isPassword;
  final int maxLines;
  final int minLines;
  final String? hintText;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final TextInputType keyboardType;
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final Function(String text)? onChanged;
  final String? labelText;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool? isPadding;
  final FocusNode? focus;
  final bool? isNumber;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final baseDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    return ValueListenableBuilder<bool>(
      valueListenable: showPassword,
      builder: (context, showPassowrdValue, _) {
        return Container(
          margin: EdgeInsets.symmetric(
         //   horizontal: isPadding == true ? context.height * .02 : 0,
            vertical: isPadding == true ? context.width * .02 : 0,
          ),
          width: double.infinity,
          child: TextFormField(

            textInputAction:textInputAction ,

            textDirection: isNumber == true ? TextDirection.ltr : null,
            focusNode: focus,
            onFieldSubmitted: onSubmitted,

            controller: controller,
            onChanged: onChanged,
            validator: validator,
            maxLines: maxLines,
            minLines: minLines,
            enabled: enabled,

            cursorColor: context.primarySwatch,
            keyboardType: isPassword
                ? TextInputType.visiblePassword
                : keyboardType,
            obscureText: isPassword ? !showPassowrdValue : false,
            style: context.bodySmall(
              color: context.themeExt.palette.black,
              fontSize: 16,
            ),
            decoration: baseDecoration.copyWith(
              suffix: suffix,
              fillColor:fillColor??context.scaffoldBackgroundColor,
              filled: true,
              hintText: hintText,
              labelText: labelText,
              labelStyle: context.bodySmall(fontSize: 16, color: context.textFieldHintColor,),
              prefixIcon: prefixIcon == null
                  ? null
                  : SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(PPadding.mainPadding),
                        child: prefixIcon,
                      ),
                    ),
              suffixIcon:
                  suffixIcon ??
                  (isPassword
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Space.hS2,
                            GestureDetector(
                              onTap: () {
                                showPassword.value = !showPassowrdValue;
                              },
                              child: SizedBox(
                                    height: 25,
                                child: showPassowrdValue
                                    ?
                                SvgAsset(
                                    Assets.images.svg.unvisibaleEyeIcon,
                                    height: 25,
                                    color:Color(0xFF141B34)

                                )

                                    :SvgAsset(
                                  Assets.images.svg.visibaleEyeIcon,
                                  height: 25,
                                    color:Color(0xFF141B34)
                                )

                                ,
                              ),
                            ),
                          ],
                        )
                      : null),
              suffixIconConstraints: const BoxConstraints(minWidth: 45),
            ),
          ),
        );
      },
    );
  }
}



class ChatTextFiled extends StatelessWidget {
  ChatTextFiled({
    super.key,
    this.hintText,
    this.textInputAction,
    this.isPassword = false,
    this.enabled = true,
    this.controller,
    this.validator,
    this.width,
    this.height,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.labelText,
    this.fillColor,
    this.onSubmitted,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.isPadding = true,
    this.focus,
    this.isNumber = false,
  });

  final bool enabled;
  final bool isPassword;
  final int maxLines;
  final int minLines;
  final String? hintText;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final TextInputType keyboardType;
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final Function(String text)? onChanged;
  final String? labelText;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool? isPadding;
  final FocusNode? focus;
  final bool? isNumber;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final baseDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: showPassword,
      builder: (context, showPasswordValue, _) {
        return SizedBox(
          width: width ?? double.infinity,
          height: height,
          child: TextFormField(
            controller: controller,
            focusNode: focus,
            enabled: enabled,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            textInputAction: textInputAction,
            keyboardType: isPassword
                ? TextInputType.visiblePassword
                : keyboardType,
            textDirection: isNumber == true ? TextDirection.ltr : null,
            obscureText: isPassword ? !showPasswordValue : false,
            maxLines: maxLines,
            minLines: minLines,
            cursorColor: context.primarySwatch,
            textAlignVertical: TextAlignVertical.center,
            style: context.bodySmall(
              color: context.themeExt.palette.black,
              fontSize: 16,
            ),
            decoration: baseDecoration.copyWith(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffix: suffix,
              filled: true,
              fillColor: fillColor,
              hintText: hintText,
              labelText: labelText,
              errorStyle: const TextStyle(fontSize: 0),
              errorMaxLines: 1,
              labelStyle: context.bodySmall(
                fontSize: 16,
                color: context.textFieldHintColor,
              ),
              prefixIcon: prefixIcon == null
                  ? null
                  : SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(PPadding.mainPadding),
                  child: prefixIcon,
                ),
              ),
              suffixIcon: suffixIcon ??
                  (isPassword
                      ? GestureDetector(
                    onTap: () {
                      showPassword.value = !showPasswordValue;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        showPasswordValue
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  )
                      : null),
            ),
          ),
        );
      },
    );
  }
}
