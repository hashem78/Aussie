import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AussieUser>(
      localUserProvider,
      (previous, next) {
        print('new state is : $next');
        next.mapOrNull(
          signedIn: (val) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProviderScope(
                    overrides: [
                      scopedUserProvider.overrideWithValue(next),
                    ],
                    child: const FeedScreen(),
                  );
                },
              ),
            );
          },
          signedOut: (val) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const InitialUserActionScreen();
                },
              ),
              (route) => !route.isFirst,
            );
          },
          firstRun: (user) {
            print('executing is first run');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return const InitialUserActionScreen();
                },
              ),
            );
          },
        );
      },
    );
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
