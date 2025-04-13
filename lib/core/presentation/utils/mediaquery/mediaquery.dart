import 'package:flutter/material.dart';

double mediaqueryHight(double x, context) {
  return MediaQuery.of(context).size.height * x;
}

double mediaqueryWidth(double x, context) {
  return MediaQuery.of(context).size.width * x;
}
