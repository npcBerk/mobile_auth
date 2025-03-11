import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_auth/core/startup/start_up_screen.dart';
import 'package:mobile_auth/main_widget.dart';

void main() {
  runApp(
    ProviderScope(
      child: StartUpScreen(builder: (context) => const MainWidget()),
    ),
  );
}
