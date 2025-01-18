import 'dart:async';

import 'package:fast_code/fast_code.dart';
import 'package:fast_code/src/fast_code.dart';
import 'package:fast_code/src/fast_config.dart';
import 'package:fast_code/src/fast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FastUi {
  static FutureOr<T?> loadingTask<T>({
    Function(dynamic)? error,
    bool loading = true,
    FutureOr Function()? task,
    EasyLoadingMaskType? maskType,
    Widget? indicator,
  }) async {
    T? result;
    try {
      if (loading) {
        EasyLoading.show(
          maskType: maskType ??
              (FastCode().config.loadingTaskWidget != null
                  ? EasyLoadingMaskType.none
                  : EasyLoadingMaskType.black),
          indicator: indicator ?? FastCode().config.loadingTaskWidget,
        );
      }
      result = await task?.call();
    } catch (e) {
      fastPrint('$e');
      error?.call(e);
    } finally {
      if (loading) EasyLoading.dismiss();
    }
    return result;
  }

  static Future<T?> showIosDialog<T>(
    context, {
    showCancel = true,
    List<TextClick<T?>>? textClick,
    String? title,
    String? desc,
  }) {
    List<CupertinoActionSheetAction> list = [];

    textClick?.forEach((element) {
      list.add(CupertinoActionSheetAction(
        isDestructiveAction: element.red,
        onPressed: () async {
          if (element.tap != null) {
            T? result = await element.tap!();
            if (context.mounted) Navigator.pop(context, result);
          } else {
            Navigator.pop(context, element.returnValue);
          }
        },
        child: Text(element.text ?? ''),
      ));
    });

    return showCupertinoModalPopup<T>(
        context: context,
        builder: (c) {
          return CupertinoActionSheet(
            title: title == null ? null : Text(title),
            message: desc == null ? null : Text(desc),
            actions: list,
            cancelButton: showCancel
                ? CupertinoActionSheetAction(
                    //取消按钮
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(FastCode().config.iosDialogCancelText),
                  )
                : null,
          );
        });
  }

  static var lightPrimaryColorDark = const Color(0xffdfdfdf);
  static var lightPrimaryColor = const Color(0xffefefef);
  static var lightPrimaryColorLight = const Color(0xffffffff);

  static var darkPrimaryColorDark = const Color(0xff000000);
  static var darkPrimaryColor = const Color(0xff101010);
  static var darkPrimaryColorLight = const Color(0xff202020);

  static var mainColor = Colors.deepOrange;
  static var mainTrColor = mainColor.withOpacity(0.5);

  static var mainGradient =
      LinearGradient(colors: [mainColor, mainColor.shade100]);

  static var darkTheme = ThemeData(
    focusColor: mainTrColor,
    //appbar tabbar 颜色从深到浅
    primaryColorDark: FastUi.darkPrimaryColorDark,
    primaryColor: FastUi.darkPrimaryColor,
    primaryColorLight: FastUi.darkPrimaryColorLight,
    // //checkbox选中
    // toggleableActiveColor: Colors.white,
    //dialog
    dialogTheme: DialogTheme(backgroundColor: FastUi.darkPrimaryColor),
    dialogBackgroundColor: FastUi.darkPrimaryColor,
    //整体为暗色
    brightness: Brightness.dark,
    //页面背景颜色
    scaffoldBackgroundColor: darkPrimaryColorDark,
    // backgroundColor: Ui.primaryColorDark,
    //侧滑主题
    drawerTheme: DrawerThemeData(backgroundColor: FastUi.darkPrimaryColorDark),
    //文本主题 都用subtitle1
    textTheme: const TextTheme(
        // subtitle1: TextStyle(
        //     textBaseline: TextBaseline.alphabetic, color: Colors.white)
        ),
    //tabbar主题
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      dividerHeight: 0,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      labelStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
      unselectedLabelStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
    ),
    //appbar主题
    appBarTheme: AppBarTheme(
      elevation: 0,
      // titleSpacing: 0,
      color: FastUi.darkPrimaryColorDark,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    //ios widget主题
    cupertinoOverrideTheme:
        const NoDefaultCupertinoThemeData(primaryColor: Colors.white),
    cardTheme: const CardTheme(margin: EdgeInsets.zero),
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: mainColor, selectionHandleColor: mainColor),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: FastUi.mainColor),
    inputDecorationTheme: const InputDecorationTheme(
        outlineBorder: null, hintStyle: TextStyle(color: Colors.grey)),

    //输入框主题
    // inputDecorationTheme: const InputDecorationTheme(
    //     labelStyle: TextStyle(fontSize: 15, color: Colors.white),
    //     fillColor: Colors.white,
    //     border: InputBorder.none,
    //     contentPadding: EdgeInsets.all(10),
    //     hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    // //图标的颜色
    // iconTheme: const IconThemeData(color: Colors.white),
  );

  static var lightTheme = ThemeData(
    focusColor: mainTrColor,

    //appbar tabbar 颜色从深到浅
    primaryColorDark: FastUi.lightPrimaryColorDark,
    primaryColor: FastUi.lightPrimaryColor,
    primaryColorLight: FastUi.lightPrimaryColorLight,
    // //checkbox选中
    // toggleableActiveColor: Colors.white,
    //dialog
    dialogTheme: DialogTheme(backgroundColor: FastUi.lightPrimaryColorLight),
    dialogBackgroundColor: FastUi.lightPrimaryColorLight,
    //整体为暗色
    brightness: Brightness.light,
    //页面背景颜色
    scaffoldBackgroundColor: lightPrimaryColorLight,
    // backgroundColor: Ui.primaryColorDark,
    //侧滑主题
    drawerTheme:
        DrawerThemeData(backgroundColor: FastUi.lightPrimaryColorLight),
    //文本主题 都用subtitle1
    textTheme: const TextTheme(
        // subtitle1: TextStyle(
        //     textBaseline: TextBaseline.alphabetic, color: Colors.white)
        ),
    //tabbar主题
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      dividerHeight: 0,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      labelStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
      unselectedLabelStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
    ),

    //appbar主题
    appBarTheme: AppBarTheme(
      elevation: 0,
      // titleSpacing: 0,
      color: FastUi.lightPrimaryColorLight,

      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    //ios widget主题
    cupertinoOverrideTheme:
        const NoDefaultCupertinoThemeData(primaryColor: Colors.black),
    cardTheme: const CardTheme(margin: EdgeInsets.zero),
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: mainColor, selectionHandleColor: mainColor),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: FastUi.mainColor),
    inputDecorationTheme: InputDecorationTheme(
        outlineBorder: null, hintStyle: TextStyle(color: Colors.grey)),

    //输入框主题
    // inputDecorationTheme: const InputDecorationTheme(
    //     labelStyle: TextStyle(fontSize: 15, color: Colors.white),
    //     fillColor: Colors.white,
    //     border: InputBorder.none,
    //     contentPadding: EdgeInsets.all(10),
    //     hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    // //图标的颜色
    // iconTheme: const IconThemeData(color: Colors.white),
  );
}

class TextClick<T> {
  FutureOr<T>? Function()? tap;
  String? text;
  bool red = false;
  T? returnValue;

  TextClick({this.tap, this.text, this.red = false, this.returnValue});
}
