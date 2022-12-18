import 'package:counter/presentation/resources/color_manager.dart';
import 'package:counter/presentation/resources/font_manager.dart';
import 'package:counter/presentation/resources/styles_manager.dart';
import 'package:counter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,

      // will be used in case of disabled button
      disabledColor: ColorManager.grey1,

      //ripple color
      splashColor: ColorManager.primaryOpacity70,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
      //button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)),
              textStyle: getRegularStyle(color: ColorManager.white))),

      //text theme
      textTheme: TextTheme(
          bodyText1: getRegularStyle(color: ColorManager.grey),
          caption: getRegularStyle(color: ColorManager.grey1),
          subtitle1: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          subtitle2: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          headline1: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16)),

      //input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          //enabled border
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5)),

          // focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5)),

          //error border
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5)),

          //Focused Error Border
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5)),

          //error style
          errorStyle: getRegularStyle(color: ColorManager.error),
          //label style
          labelStyle: getMediumStyle(color: ColorManager.darkGrey),
          //hint style
          hintStyle: getRegularStyle(color: ColorManager.grey1),
          contentPadding: const EdgeInsets.all(AppPadding.p8)));
}
