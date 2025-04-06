import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:trashscan/screens/about_team_screen.dart';
import 'package:trashscan/screens/account_edit_screen.dart';
import 'package:trashscan/screens/account_registration_screen.dart';
import 'package:trashscan/screens/account_screen.dart';
import 'package:trashscan/screens/advancement_screen.dart';
import 'package:trashscan/screens/diary_screen.dart';
import 'package:trashscan/screens/education_screen.dart';
import 'package:trashscan/screens/map_screen.dart';
import 'package:trashscan/screens/scan_screen.dart';
import 'package:trashscan/screens/setting_screen.dart';
import 'package:trashscan/screens/home_screen.dart';
import 'package:trashscan/screens/Notification_setting_screen.dart';
import 'package:trashscan/screens/trashDict_screen.dart';

GoRouter appRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/diary',
        pageBuilder: (context, state) => NoTransitionPage(
          child: DiaryScreen(),
        ),
      ),
      GoRoute(
        path: '/scan',
        pageBuilder: (context, state) => NoTransitionPage(
          child: ScanScreen(),
        ),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) {
          final int? trashId = state.extra as int?;
          return MapScreen(targetTrashId: trashId);
        },
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => NoTransitionPage(
          child: SettingScreen(),
        ),
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AboutTeamScreen(),
        ),
      ),
      GoRoute(
        path: "/NotificationSetting",
        pageBuilder: (context, state) => NoTransitionPage(
          child: NotificationSettingsScreen(),
        ),
      ),
      GoRoute(
        path: "/trashDict",
        pageBuilder: (context, state) => NoTransitionPage(
          child: TrashdictScreen(),
        ),
      ),
      GoRoute(
        path: '/education/:id',
        name: 'education',
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return NoTransitionPage(
            child: EducationScreen(id: id),
          );
        },
      ),
      GoRoute(
        path: "/account",
        pageBuilder: (context, state) => NoTransitionPage(
          child: AccountScreen(),
        ),
      ),
      GoRoute(
        path: "/advancement",
        pageBuilder: (context, state) => NoTransitionPage(
          child: AdvancementScreen(),
        ),
      ),
      GoRoute(
        path: "/account_edit",
        pageBuilder: (context, state) => NoTransitionPage(
          child: AccountEditScreen(),
        ),
      ),
      GoRoute(
        path: "/account_registration",
        pageBuilder: (context, state) => NoTransitionPage(
          child: AccountRegistrationScreen(),
        ),
      ),
    ],
  );
}
