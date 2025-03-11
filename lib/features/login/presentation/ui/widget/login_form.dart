import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_auth/common/extension/string_hardcoded.dart';
import 'package:mobile_auth/common/style/dimens.dart';
import 'package:mobile_auth/features/login/presentation/controller/login_controller.dart';
import 'package:mobile_auth/features/login/presentation/ui/widget/dont_have_account.dart';
import 'package:mobile_auth/features/login/presentation/ui/widget/forgot_password.dart';
import 'package:mobile_auth/features/login/presentation/ui/widget/login_button.dart';
import 'package:mobile_auth/features/login/presentation/ui/widget/login_with.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: "emilys@gmail.com");
    _passwordController = TextEditingController(text: "emilyspass");
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listener();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Username'.hardcoded,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(kSmall)),
                  ),
                  prefix: const Icon(Icons.email),
                ),
                /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username'.hardcoded;
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid username'.hardcoded;
                  }
                  return null;
                }, */
              ),
              const SizedBox(height: kMedium),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'.hardcoded,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(kSmall)),
                  ),
                  prefix: const Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'.hardcoded;
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long'
                        .hardcoded;
                  }
                  return null;
                },
              ),
              const ForgotPassword(),
              const SizedBox(height: kSmall),
              LoginButton(onPressed: _login),
              const SizedBox(height: kLarge),
              const LoginWith(),
              const SizedBox(height: kLarge),
              const DontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  void _listener() {
    // listen for error
    ref.listen(loginControllerProvider.select((value) => value.error), (
      _,
      next,
    ) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            content: Text(next),
          ),
        );
      }
    });
    // listen for success
    ref.listen(
      loginControllerProvider.select((value) => value.isLoginSuccess),
      (_, next) {
        if (next) {
          context.go('/home');
        }
      },
    );
  }

  void _login() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // collect form data from controllers
      final formData = {
        'username': _usernameController.text,
        'password': _passwordController.text,
      };

      // set form data
      ref.read(loginControllerProvider.notifier).setFormData(formData);
      // login - call api
      ref.read(loginControllerProvider.notifier).login();
    }
  }
}
