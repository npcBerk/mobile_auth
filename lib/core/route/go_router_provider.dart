import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_auth/core/provider/auth_state_provider.dart';
import 'package:mobile_auth/core/route/route_name.dart';
import 'package:mobile_auth/features/home/presentation/ui/home_screen.dart';
import 'package:mobile_auth/features/login/presentation/ui/login_screen.dart';
import 'package:mobile_auth/features/signup/presentation/ui/signup_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: "/$loginRoute",
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/$loginRoute';

      if (authState) {
        if (isGoingToLogin) {
          return '/$homeRoute';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/$loginRoute',
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/$singupRoute',
        name: singupRoute,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        name: homeRoute,
        builder: (context, state) => const HomeScreen(),
        /* routes: [
          GoRoute(
            path: 'setting',
            name: settingRoute,
            builder: (context, state) => const SettingScreen(),
          ),
        ], */
      ),
    ],
  );
});
