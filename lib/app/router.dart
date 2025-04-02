import 'package:go_router/go_router.dart';
import 'package:trashscan/screens/about_team_screen.dart';
import 'package:trashscan/screens/diary_screen.dart';
import 'package:trashscan/screens/education_screen.dart';
import 'package:trashscan/screens/map_screen.dart';
import 'package:trashscan/screens/scan_screen.dart';
import 'package:trashscan/screens/setting_screen.dart';
import '../screens/home_screen.dart';
import 'package:trashscan/screens/Notification_setting_screen.dart';
import 'package:trashscan/screens/trashDict_screen.dart';

// import '../screens/second_screen.dart';
// import '../screens/profile_screen.dart';

// Define GoRouter instance
final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/diary',
      builder: (context, state) => DiaryScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => ScanScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => MapScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutTeamScreen(),
    ),
    GoRoute(
      path: "/NotificationSetting",
      builder: (context, state) => NotificationSettingsScreen(),
    ),
    GoRoute(
      path: "/trashDict",
      builder: (context, state) => TrashdictScreen(),
    ),
    GoRoute(
      path: '/education/:id',
      name: 'education',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EducationScreen(id: id);
      },
    ),
  ],
);
