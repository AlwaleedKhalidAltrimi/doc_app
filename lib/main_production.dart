import 'package:flutter/material.dart';
import 'core/app/doc_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/routes/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  setupGetIt();

  // Fix text hidden bug in flutter_screenutil release mode
  await ScreenUtil.ensureScreenSize();
  runApp(DocApp(appRouter: AppRouter()));
}
