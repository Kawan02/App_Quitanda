import 'dart:async';

import 'package:app_quitanda/src/auth/sign_in_screen.dart';
import 'package:app_quitanda/src/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  final sessionStateStream = StreamController<SessionState>();

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 20),
      invalidateSessionForUserInactivity: const Duration(seconds: 20),
    );

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      sessionStateStream.add(SessionState.stopListening);
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      // Página de Login
        _navigator.pushReplacement(
          MaterialPageRoute(
            builder: (_) => SignInScreen(
              sessionStateStream: sessionStateStream,
            ),
          ),
        );
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // Página home
        _navigator.pushReplacement(
          MaterialPageRoute(
            builder: (_) => BaseScreen(
              sessionStateStream: sessionStateStream,
            ),
          ),
        );
      }
    });

    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: sessionStateStream.stream,
      child: MaterialApp(
        title: 'Projeto Quitanda',
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey.withAlpha(30),
        ),
        home: SignInScreen(sessionStateStream: sessionStateStream),
      ),
    );
  }
}
