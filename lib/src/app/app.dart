import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_it_app/core/common/themes/theme.dart';
import 'package:run_it_app/core/router/router.dart';

class RunItApp extends StatelessWidget {
  const RunItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp.router(
            title: 'Run It',
            theme: AppTheme.cupertinoTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.routerConfig,
          )
        : MaterialApp.router(
            title: 'Run It',
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.routerConfig,
          );
  }
}
