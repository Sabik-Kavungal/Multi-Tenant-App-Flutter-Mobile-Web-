import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/features/auth/viewmodels/auth_vm.dart';

/// Splash Page
/// STRICT MVVM: Pure UI, zero business logic
/// Triggers ViewModel restoreSession on first build
/// ViewModel handles all logic and navigation decisions
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get ViewModel
    final authVm = context.read<AuthViewModel>();

    // Set context for API calls (needed for token refresh)
    authVm.setContext(context);

    // Set up navigation callback - ViewModel decides, UI executes
    authVm.onNavigate = (route) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    };

    // Trigger session restoration on first build
    // Using post-frame callback to avoid calling async in build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authVm.restoreSession();
    });

    // Pure UI - just shows loading indicator
    // ViewModel manages loading state, but we show static loading here
    // since restoreSession happens asynchronously
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
