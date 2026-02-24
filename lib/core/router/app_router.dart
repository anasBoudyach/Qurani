import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/app_shell.dart';
import '../../features/home/presentation/screens/dashboard_screen.dart';
import '../../features/quran/presentation/screens/quran_browse_screen.dart';
import '../../features/audio/presentation/screens/reciter_list_screen.dart';
import '../../features/tajweed_course/presentation/screens/course_home_screen.dart';
import '../../features/settings/presentation/screens/more_screen.dart';
import 'route_names.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _quranNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'quran');
final _listenNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'listen');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _learnNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'learn');
final _moreNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'more');

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RouteNames.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Quran
        StatefulShellBranch(
          navigatorKey: _quranNavigatorKey,
          routes: [
            GoRoute(
              path: RouteNames.quran,
              builder: (context, state) => const QuranBrowseScreen(),
            ),
          ],
        ),
        // Tab 2: Listen
        StatefulShellBranch(
          navigatorKey: _listenNavigatorKey,
          routes: [
            GoRoute(
              path: RouteNames.listen,
              builder: (context, state) => const ReciterListScreen(),
            ),
          ],
        ),
        // Tab 3: Home (center, landing)
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        // Tab 4: Learn (Tajweed Course)
        StatefulShellBranch(
          navigatorKey: _learnNavigatorKey,
          routes: [
            GoRoute(
              path: RouteNames.learn,
              builder: (context, state) => const CourseHomeScreen(),
            ),
          ],
        ),
        // Tab 5: More
        StatefulShellBranch(
          navigatorKey: _moreNavigatorKey,
          routes: [
            GoRoute(
              path: RouteNames.more,
              builder: (context, state) => const MoreScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
