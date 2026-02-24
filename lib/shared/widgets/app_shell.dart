import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/audio/presentation/widgets/mini_player_widget.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayerWidget(),
          NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Quran',
              ),
              NavigationDestination(
                icon: Icon(Icons.headphones_outlined),
                selectedIcon: Icon(Icons.headphones),
                label: 'Listen',
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_outline_rounded),
                selectedIcon: Icon(Icons.bookmark_rounded),
                label: 'Bookmarks',
              ),
              NavigationDestination(
                icon: Icon(Icons.more_horiz_outlined),
                selectedIcon: Icon(Icons.more_horiz),
                label: 'More',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
