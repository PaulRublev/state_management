import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';

import 'src/app.dart';

void main() async {
  BlocFactory.instance.initialize();
  runApp(MyApp());
}
