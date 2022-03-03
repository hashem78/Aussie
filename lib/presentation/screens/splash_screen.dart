import 'package:evento/presentation/screens/feed/feed_screen.dart';
import 'package:evento/presentation/screens/usermanagement/initial_actions.dart';
import 'package:evento/state/user_management.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(localUserProvider).map(
      signedIn: (_) {
        return const FeedScreen();
      },
      loading: (_) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      signedOut: (_) {
        return const InitialUserActionScreen();
      },
      error: (err) {
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
