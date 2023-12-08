import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WarungScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const WarungScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/books/popular');
          if (idx == 1) goRouter.go('/authors');
          if (idx == 2) goRouter.go('/roles');
          if (idx == 3) goRouter.go('/settings');
          if (idx == 4) goRouter.go('/users');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Dashboard',
            icon: Icons.home,
          ),
          AdaptiveScaffoldDestination(
            title: 'Pengguna',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Roles',
            icon: Icons.create,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
          AdaptiveScaffoldDestination(
            title: 'Users',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
