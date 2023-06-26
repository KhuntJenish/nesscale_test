import 'package:flutter/material.dart';

bool get isDarkMode => false;

Color setColor(Color lightModeColor, [Color? darkModeColor]) =>
    darkModeColor != null && isDarkMode ? darkModeColor : lightModeColor;

String get getPoppinsFontFamily => 'Poppins'; //! Default
String get getRobotoFontFamily => 'Roboto';
String get getLatoFontFamily => 'Lato';
String get getInterFontFamily => 'Inter';

const lPrimaryColor = Colors.deepPurple;

const pureBlackColor = Colors.black;
const pureWhiteColor = Colors.white;

const lbgColor = Color(0xffF9F9F9);

const lLinearGradientColor1 = Color.fromARGB(255, 111, 69, 183);
const lLinearGradientColor2 = Colors.deepPurple;

const lPrimaryTextColor = Color.fromARGB(255, 11, 10, 12);

const lHintColor = Color(0xffADABB7);

const greyColor1 = Color(0xffB0B0B0);
const greyColor2 = Color(0xff898989);
const greyColor3 = Color(0xff727272);
const greyColor4 = Color(0xff858585);
const greyColor5 = Color(0xffE2E2E2);
const greyColor6 = Color(0xffB4B3B3);
const greyColor7 = Color(0xff747688);
const greyColor8 = Color(0xffEDEDED);
const greyColor9 = Color(0xffA0AEC0);
const greyColor10 = Color(0xffE0E0E0);

const whiteColor1 = Color(0xffFCFCFA);

const blackColor1 = Color(0xff141414);
const blackColor2 = Color(0xff25251C);
const blackColor3 = Color(0xff2D3748);

const redColor = Color(0xffFF3B30);
const lightRed = Color(0xffFF5656);
const blueColor = Color(0xff007AFF);
const orangeColor = Color(0xffEB7100);
const greenColor = Color(0xff04B92C);
const darkBlueColor = Color(0xff464EA1);
const yellowColor = Color(0xffFFA756);

Color get getBgColor => setColor(lbgColor);
Color get getPrimaryColor => setColor(lPrimaryColor);
Color get getPrimaryTextColor => setColor(lPrimaryTextColor);
// Color get getBWColor => setColor(pureBlackColor, pureWhiteColor);
// Color get getWBColor => setColor(pureWhiteColor, pureBlackColor);

Color get getColor1 => setColor(greyColor1);
Color get getColor2 => setColor(greyColor2);
Color get getColor3 => setColor(greyColor3);
Color get getColor4 => setColor(greyColor4);
Color get getColor5 => setColor(greyColor5);
Color get getColor6 => setColor(greyColor6);
Color get getColor7 => setColor(greyColor7);
Color get getColor8 => setColor(greyColor8);
Color get getColor9 => setColor(greyColor9);
Color get getColor10 => setColor(greyColor10);

Color get getColor11 => setColor(pureBlackColor);
Color get getColor12 => setColor(blackColor1);
Color get getColor13 => setColor(blackColor2);
Color get getColor14 => setColor(blackColor3);

Color get getColor21 => setColor(pureWhiteColor);
Color get getColor22 => setColor(whiteColor1);

Color get getHintColor => setColor(lHintColor);

Color get getLinearGradientColor1 => setColor(lLinearGradientColor1);
Color get getLinearGradientColor2 => setColor(lLinearGradientColor2);
