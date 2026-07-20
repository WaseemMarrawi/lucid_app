import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_menu/common/design/design.dart';
import 'package:restaurants_menu/common/design/src/widgets/animation_widget/animated_scale_widget.dart';
import 'package:restaurants_menu/common/extensions/src/validation.dart';
import 'package:restaurants_menu/features/review/domin/use_cases/review_service_use_case.dart';
import 'package:restaurants_menu/features/review/presentation/widgets/app_bar_widget.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../../core/di/injection.dart';
import '../bloc/review_bloc.dart';
import '../widgets/custom_rating_widget.dart';
import '../widgets/phone_table_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final ReviewBloc reviewBloc;
  late final GlobalKey<FormState> _globalKey;
  late final ValueNotifier<double> serviceRate;
  late final ValueNotifier<double> cleanRate;
  late final ValueNotifier<double> foodRate;
  late final TextEditingController phoneNumber;
  late final TextEditingController noteController;
  late final TextEditingController extraNoteController;

  ///
  late final TextEditingController tableController;

  @override
  void initState() {
    reviewBloc = getIt<ReviewBloc>();

    _globalKey = GlobalKey<FormState>();

    phoneNumber = TextEditingController();
    noteController = TextEditingController();
    extraNoteController = TextEditingController();

    tableController = TextEditingController();

    serviceRate = ValueNotifier(0);
    cleanRate = ValueNotifier(0);
    foodRate = ValueNotifier(0);

    super.initState();
  }

  @override
  void dispose() {
    reviewBloc.close();

    phoneNumber.dispose();
    noteController.dispose();
    extraNoteController.dispose();
    tableController.dispose();
    serviceRate.dispose();
    cleanRate.dispose();
    foodRate.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBarWidget(),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: Column(

                    children: [
                      Space.vM1,

                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          LocaleKeys.rating.tr(),
                          style: context.headlineSmall(fontSize: 24),
                        ),
                      ),
                      Space.vM1,
                      Container(
                        width: context.isDesktop ? context.width * .7 : null,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: context.dividerColor),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              LocaleKeys.ratingDescription.tr(),
                              style: context.headlineSmall(fontSize: 14),
                            ),
                            Space.vM1,
                            ResponsiveRowColumn(
                              layout: context.isDesktop
                                  ? ResponsiveRowColumnType.ROW
                                  : ResponsiveRowColumnType.COLUMN,
                              rowMainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                /// SERVICE
                                ResponsiveRowColumnItem(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.serviceRating.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      CustomRatingWidget(rate: serviceRate),
                                    ],
                                  ),
                                ),

                                /// CLEANLINESS
                                ResponsiveRowColumnItem(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.cleanlinessRating.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      CustomRatingWidget(rate: cleanRate),
                                    ],
                                  ),
                                ),

                                /// FOOD
                                ResponsiveRowColumnItem(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.foodRating.tr(),
                                            style: context.bodyLarge(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Space.hS2,
                                          Text(
                                            LocaleKeys.required.tr(),
                                            style: context.bodyMedium(
                                              fontSize: 12,
                                              color: context.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Space.vS3,
                                      CustomRatingWidget(rate: foodRate),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            PhoneTableWidget(
                              phoneController: phoneNumber,
                              tableController: tableController,
                            ),
                            Space.vM1,
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.overallExperience.tr(),
                                  style: context.bodyLarge(fontSize: 14),
                                ),
                                Space.hS2,
                                Text(
                                  LocaleKeys.required.tr(),
                                  style: context.bodyMedium(
                                    fontSize: 12,
                                    color: context.errorColor,
                                  ),
                                ),
                              ],
                            ),
                            Space.vS3,
                            MyAppTextField(
                              isPadding: false,
                              minLines: 4,
                              maxLines: 6,
                              controller: extraNoteController,
                              validator: (text) => text.isNotEnderThreeText,
                            ),
                            Space.vM4,
                            Text(
                              LocaleKeys.additionalComment.tr(),
                              style: context.bodyLarge(fontSize: 14),
                            ),
                            Space.vS3,
                            MyAppTextField(
                              isPadding: false,
                              minLines: 4,
                              maxLines: 6,
                              controller: noteController,
                            ),
                          ],
                        ),
                      ),
                      Space.vS3,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Divider(height: 1),
                Container(
                  width: context.isMobile
                      ? context.width
                      : context.isTablet
                      ? context.width * .7
                      : context.width * .5,

                  // color: Colors.white,
                  padding: EdgeInsets.only(
                    bottom: context.navigationBarHeight + 10,
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedScaleWidget(
                          child: OutlinedButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              LocaleKeys.cancel.tr(),
                              style: context.bodyLarge(
                                fontSize: 16,
                                color: context.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Space.hS3,
                      Expanded(
                        child: BlocListener<ReviewBloc, ReviewState>(
                          bloc: reviewBloc,
                          listenWhen: (pre, cur) =>
                              pre.reviewServiceData.status !=
                              cur.reviewServiceData.status,
                          listener: (context, state) {
                            state.reviewServiceData.listenerFunction(
                              onSuccess: () => context.pop(),
                            );
                          },
                          child: AnimatedScaleWidget(
                            child: ElevatedButton(
                              onPressed: () {
                                if (!(_globalKey.currentState?.validate() ??
                                    false)) {
                                  return;
                                }
                            
                                if (serviceRate.value == 0) {
                                  Toaster.showCustomErrorToast(
                                    message: LocaleKeys.unrateError.tr(
                                      namedArgs: {
                                        "value": LocaleKeys.serviceRating.tr(),
                                      },
                                    ),
                                  );
                                } else if (cleanRate.value == 0) {
                                  Toaster.showCustomErrorToast(
                                    message: LocaleKeys.unrateError.tr(
                                      namedArgs: {
                                        "value": LocaleKeys.cleanlinessRating
                                            .tr(),
                                      },
                                    ),
                                  );
                                } else if (foodRate.value == 0) {
                                  Toaster.showCustomErrorToast(
                                    message: LocaleKeys.unrateError.tr(
                                      namedArgs: {
                                        "value": LocaleKeys.foodRating.tr(),
                                      },
                                    ),
                                  );
                                } else {
                                  reviewBloc.add(
                                    ReviewServiceEvent(
                                      params: ReviewServiceParams(
                                        customerPhone: phoneNumber.text,
                                        cleanRate: cleanRate.value,
                                        experience: extraNoteController.text,
                                        foodRate: foodRate.value,
                                        notes: noteController.text,
                                        serviceRate: serviceRate.value,
                                        tableNumber: tableController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                LocaleKeys.sendRate.tr(),
                                style: context.headlineSmall(
                                  fontSize: 16,
                                  color: context.scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
