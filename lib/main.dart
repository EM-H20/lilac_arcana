import 'package:flutter/material.dart';
import 'package:lilac_arcana/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lilac_arcana/providers/tarot_provider.dart';
import 'package:lilac_arcana/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TarotProvider(),
      child: const LilacArcanaApp(),
    ),
  );
}

class LilacArcanaApp extends StatelessWidget {
  const LilacArcanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 디자인 기준 사이즈 (e.g., iPhone X)
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'Lilac Arcana',
          theme: AppTheme.lightTheme,
          builder: (context, router) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: router!,
            );
          },
        );
      },
    );
  }
}
