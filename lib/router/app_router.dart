import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lilac_arcana/screens/card_info/card_detail_page.dart';
import 'package:lilac_arcana/screens/card_info/card_info_page.dart';
import 'package:lilac_arcana/screens/daily_card/daily_card_page.dart';
import 'package:lilac_arcana/screens/home/home_page.dart';
import 'package:lilac_arcana/screens/main_navigation/main_navigation_screen.dart';
import 'package:lilac_arcana/screens/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        // 홈 탭
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // 카드 정보 탭
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/card-info',
              builder: (context, state) => const CardInfoPage(),
              routes: [
                GoRoute(
                  path: ':cardId',
                  builder: (context, state) {
                    final cardId = int.parse(state.pathParameters['cardId']!);
                    return CardDetailPage(cardId: cardId);
                  },
                ),
              ],
            ),
          ],
        ),
        // 오늘의 카드 탭
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/daily-card',
              builder: (context, state) => const DailyCardPage(),
            ),
          ],
        ),
        // 설정 탭
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
