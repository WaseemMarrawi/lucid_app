import '../../helper/src/app_varibles.dart';
import '../../helper/src/locale_keys.dart';
import '../../models/description_model.dart';

extension DescriptionModelX on DescriptionModel? {
  String getName({String? emptyText}) {
    final code = AppVariables.getCurrentLang();

    final value = switch (code) {
      'ar' => this?.ar,
      'en' => this?.en,
      'tr' => this?.ku,
      _ => this?.ar,
    };

    return (value?.trim().isNotEmpty == true)
        ? value!
        : emptyText?? LocaleKeys.nullText.tr();
  }
}