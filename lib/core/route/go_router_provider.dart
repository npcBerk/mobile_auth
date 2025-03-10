import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_auth/core/route/route_name.dart';
import 'package:mobile_auth/featuers/login/presentation/ui/login_screen.dart';
import 'package:mobile_auth/featuers/signup/presentation/ui/signup_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/$loginRoute",
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
    ],
  );
});
