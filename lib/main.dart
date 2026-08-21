import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import '../router/app_router.dart';
import 'common/design/design.dart';
import 'common/design/src/theme/theme/theme_notifier.dart';
import 'common/helper/helper.dart';
import 'core/di/injection.dart';
import 'package:device_preview/device_preview.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureInjection();
  HydratedBloc.storage = getIt<HydratedStorage>();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fa')],

      path: 'assets/translations',

      fallbackLocale: const Locale('ar'),

      child: ChangeNotifierProvider<AppThemeNotifier>(
        create: (_) => getIt<AppThemeNotifier>(),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: DevicePreview(
        enabled: false,
        builder: (context) {
          return MaterialApp(
            navigatorKey: AppVariables.navigatorKey,
            localizationsDelegates: context.localizationDelegates,

            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: context.watch<AppThemeNotifier>().themeData,
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            initialRoute: RouteName.splash,
            onGenerateRoute: RouteManager.onGenerateRoute,
          );
        },
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 801, name: TABLET),
        const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
      ],
    );
  }
}

//{
//  "retry": "Dîsa biceribîne",
//  "nullText": "Tune ye",
//  "emptyCount": "Ne heye",
//  "validation": {
//    "requiredField": "Ev qada pêwîst e.",
//    "invalidEmailAddress": "Ji kerema xwe navnîşana e-nameyeke derbasdar binivîse.",
//    "passwordTooShort": "Divê şîfre herî kêm 8 tîpan be.",
//    "passwordsDoNotMatch": "Şîfreyên hev nagirin.",
//    "invalidPhoneNumber": "Ji kerema xwe jimareya têlefonê derbasdar binivîse.",
//    "fieldTooShort": "Divê herî kêm {4} tîp be.",
//    "fieldNameTooShort": "Divê herî kêm {2} tîp be.",
//    "fieldNameTooShortFour": "Divê herî kêm {3} tîp be.",
//    "fieldNameTooLong": "Divê herî zêde {15} tîp be.",
//    "plateTooLong": "Divê herî zêde {16} tîp be.",
//    "errorDate": "Nirxên dîroka jidayikbûnê divê hejmar bin",
//    "validationInvalidDay": "Divê roj di navbera 1 û {max} de be",
//    "validationInvalidMonth": "Divê meh di navbera 1 û 12 de be",
//    "validationInvalidYear": "Divê sal di nav 100 salên dawî de be",
//    "fieldTooLong": "Ev qada divê herî zêde {100} tîp nebe.",
//    "invalidCharacters": "Hin tîp ne destûrdayî ne.",
//    "addNote": "Ji kerema xwe notê zêde bike",
//    "passwordNotStrong": "Şîfre pir qewî nîne, divê tîpên mezin û piçûk, hejmar û sembol hebin.",
//    "errorCities": "Di barkirina bajar û beşan de xeletî çêbû. Ji kerema xwe paşê dîsa biceribîne.",
//    "validationPinLength": "Divê koda verastkirinê ji 6 hejmaran pêk were",
//    "validationPinNumbersOnly": "Divê kod tenê hejmar be",
//    "linkInvalid": "Link nederbasdar e"
//  },
//  "errorMassege": {
//    "success": "Serkeftin",
//    "badRequestError": "Daxwazê xelet e. Daneyên şandî kontrol bike.",
//    "noContent": "Naverok tune ye",
//    "forbiddenError": "Tu destûr nadî ji vê naverokê re.",
//    "unauthorizedError": "Tu têketî nîne, ji kerema xwe têkeve.",
//    "notFoundError": "Hesab nehatiye dîtin, kontrol bike an jî hesabek çêke.",
//    "conflictError": "Nekokî",
//    "blockedError": "Girtî ye",
//    "internalServerError": "Di serverê de xeletî çêbû. Paşê dîsa biceribîne.",
//    "notAllowed": "Ev kirin ji bo te ne destûrdayî ye",
//    "unknownError": "Xeleta ne nas",
//    "timeoutError": "Demê girêdanê qediya, internetê kontrol bike û dîsa biceribîne.",
//    "defaultError": "Xeleta standard",
//    "cacheError": "Xeleta cache",
//    "noInternetError": "Girêdana internetê kontrol bike û dîsa biceribîne."
//  },
//  "rating": {
//    "rateDriver": "Şofêr binirxîne",
//    "note": "Not",
//    "writeNote": "Not / şîrove binivîse",
//    "willU": "Ma tu ê dîsa bi heman şofêr re bixebitî?",
//    "yes": "Erê",
//    "no": "Na",
//    "save": "Tomar bike",
//    "rateSuc": "Şofêr bi serkeftî hat nirxandin"
//  },
//  "auth": {
//    "signIn": "Hesab çêke",
//    "fullName": "Navê tevahî",
//    "enterFullName": "Navê tevahî",
//    "enterPin": "Koda verastkirinê binivîse",
//    "next": "Pêş",
//    "step": "Gava ",
//    "letsGiveU": "Bila em ji bo te ezmûnek taybet û xweş amade bikin!",
//    "birthDat": "Rojbûna te (vê hilbijartinî ye)",
//    "day": "Roj",
//    "month": "Meh",
//    "year": "Sal",
//    "pleaseFillAllOrNever": "Ji kerema xwe hemû qadên dîroka jidayikbûnê dagirin an jî hemûyan vala bihêlin.",
//    "doLinkYourAccount": "Hesabê xwe bi me re girêde!",
//    "pinWrong": "Koda ku te nivîsand xelet e, dîsa biceribîne",
//    "logIn": "Têketin",
//    "enterMobileAndPassword": "Jimareya têlefon û şîfre binivîse",
//    "enterPhone": "Jimareya têlefonê",
//    "countrySample": "Koda welatê",
//    "confirmPassword": "Şîfre piştrast bike",
//    "forgetPass": "Şîfreyê ji bîr kir?",
//    "wrongCode": "Koda ku te nivîsand xelet e, dîsa biceribîne",
//    "confirmedSuc": "Bi serkeftî hate piştrast kirin",
//    "dontHave": "Hesabê te tune ye?",
//    "signUp": "Hesab çêke",
//    "orSignWith": "An jî têkeve bi",
//    "createNewAccount": "Hesabeke nû çêke",
//    "alreadyHave": "Hesabê te heye?",
//    "confirm": "Piştrast bike",
//    "reSend": "Dîsa bişîne",
//    "restorePassword": "Şîfre vegerîne",
//    "reSitPassword": "Şîfreyê ji nû ve çêke",
//    "enterNewPassword": "Ji kerema xwe şîfreya nû binivîse",
//    "confirmed": "Hat verast kirin",
//    "welcome": "Bi xêr hatî",
//    "gladToWorkWithYou": "Em kêfxweş in ku em bi te re dixebitin",
//    "userEmail": "E-name",
//    "enterUserEmail": "E-name binivîse",
//    "enterPassword": "Şîfre binivîse",
//    "password": "Şîfre",
//    "forgotPassword": "Şîfreyê ji bîr kir?",
//    "forgotPasswordDesc": "E-name an jî jimareya têlefonê binivîse da em koda verastkirinê bişînin te.",
//    "enterCode": "Kod binivîse",
//    "login": "Têketin",
//    "gtExpressForLogisticsServices": "GT Express ji bo xizmetên lojîstîk",
//    "checkEmail": "Kod kontrol bike",
//    "weHaveSent": "Em koda verastkirinê ya 6 hejmarî şandine e-nameya te.",
//    "setNewPassword": "Şîfreya nû destnîşan bike",
//    "setNewPasswordDesc": "Ji kerema xwe şîfreya nû binivîse û piştrast bike.",
//    "updatePassword": "Şîfreyê nû bike",
//    "backToLogin": "Vegere têketinê",
//    "creatingConfirm": "Bi çêkirina vê hesabê tu qebûl dikî ",
//    "privacyPolicy": "Polîtîkaya nepenîtiyê",
//    "mustAcceptPrivacyPolicy": "Divê tu polîtîkaya nepenîtiyê qebûl bikî"
//  },
//  "home": {
//    "homeMenu": "Lîsteya sereke",
//    "addToCart": "Zêde bike li selikê",
//    "remove": "Rake",
//    "ingredients": "Pêkhatin",
//    "extras": "Zêdekirin",
//    "notes": "Nîşe",
//    "addYourNotesHere": "Nîşeyên xwe li vir zêde bike",
//    "notesPlaceholder": "Li vir em nîşe dinivîsin",
//    "currency": "SYP",
//    "cart": "Selik",
//    "selectOrderType": "Cureyê fermanê hilbijêre",
//    "required": "(pêwîst)",
//    "takeaway": "Derve",
//    "dineIn": "Nav mal",
//    "nextWithPrice": "Pêş ({value} SYP)",
//    "noData": "Hê {data} tune ye",
//    "noDataDesc": "Restoran dê {data} zû zêde bike",
//    "pleaseReload": "Ji kerema xwe paşê rûpelê nû bike.",
//    "data": "Daney",
//    "cartEmpty": "Hîç hilber ne di selika te de ne. Dest pê bike zêdekirinê.",
//    "popular": "Navdar",
//    "cartEmptyMessage": "Selik vala ye. Berhem zêde bike."
//  },
//  "welcome": {
//    "welcomeTitle": "Çîrokek ji tam û kêfên bîranîna nemir",
//    "welcomeSubTitle": "Her xwarin çîrokek ji tamên taybet e",
//    "rateResto": "Restoran binirxîne"
//  },
//  "exit": {
//    "exitConfirmationTitle": "Pejirandina derketinê",
//    "exitConfirmationMessage": "Tu dixwazî ji sepanê derkevî?",
//    "exitConfirmationBack": "Vegere",
//    "exitConfirmationExit": "Derkeve"
//  },
//  "version": {
//    "aNewVersion": "Versiyonek nû heye",
//    "thisVersionForce": "Ev versiyon êdî nayê piştgirî kirin. Ji kerema xwe nû bike.",
//    "updateNow": "Niha nû bike",
//    "thisVersionSuggest": "Versiyona nû bi taybetmendiyên nû amade ye."
//  },
//  "rate": {
//    "rating": "Nirxandin",
//    "ratingDescription": "Nêrînên we ji bo me girîng in",
//    "serviceRating": "Nirxandina xizmetê",
//    "required": "(pêwîst)",
//    "cleanlinessRating": "Nirxandina paqijiyê",
//    "foodRating": "Nirxandina xwarinê",
//    "phoneNumber": "Jimareya têlefonê",
//    "tableNumber": "Jimareya maseyê",
//    "overallExperience": "Tecrûbeya giştî?",
//    "additionalComment": "Şîroveyên zêde",
//    "cancel": "Betal bike",
//    "sendRate": "Nirxandin bişîne",
//    "unrateError": "Ji kerema xwe {value} dagire"
//  },
//  "submitOrder": {
//    "confirmFinalInvoice": "Pejirandina hesabê dawî",
//    "finalCost": "Bihayê dawî",
//    "iHavePromoCode": "Koda promo heye",
//    "promoCode": "Koda promo",
//    "subtotal": "Koma giştî",
//    "name": "Nav",
//    "phoneNumber": "Jimareya têlefonê",
//    "detailedLocation": "Cihê bi hûrgulî",
//    "otherNotes": "Nîşeyên din",
//    "submitOrder": "Ferman bişîne",
//    "manualPaymentOnDelivery": "Parê danê dema gihandinê",
//    "enterTableNumber": "Jimareya maseyê binivîse",
//    "manualPaymentAtCashier": "Parê li kassayê",
//    "priceValue": "{value} SYP"
//  },
//  "productDetails": {
//    "calories": "Kalorî: {value}",
//    "ingredients": "Pêkhatin",
//    "additions": "Zêdekirin",
//    "notes": "Nîşe",
//    "addYourNotesHere": "Nîşeyên xwe zêde bike",
//    "notesPlaceholder": "Li vir nîşe dinivîsin",
//    "addToCart": "Zêde bike li selikê",
//    "imageCounter": "{current} / {total}"
//  },
//  "cartDialog": {
//    "clearCartTitle": "Selikê vala bike",
//    "clearCartDescription": "Tu piştrast î ku dixwazî selika xwe vala bikî? Hemû berhemên zêdekirî dê werin rakirin.",
//    "clearCartConfirm": "Selikê vala bike",
//    "clearCartCancel": "Vegere"
//  }
//}
//
