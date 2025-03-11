import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_auth/core/route/route_name.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Signup Screen'),
            IconButton.filled(
              onPressed: () {
                context.push( '/$loginRoute');
              }, 
              icon: const Icon(Icons.login_outlined),
            )
          ],
        ),
      ),
    );
  }
}