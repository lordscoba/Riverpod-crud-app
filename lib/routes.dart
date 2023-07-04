import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testriverpod/apicalls/users.dart';
import 'package:testriverpod/screens/apiwidgets.dart';
import 'package:testriverpod/screens/createform.dart';
import 'package:testriverpod/screens/getsingleuser.dart';
import 'package:testriverpod/screens/gettest.dart';
import 'package:testriverpod/screens/updateuser.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouter configuration
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            ref.read(usersProvider);
            ref.invalidate(usersProvider);
            return const MyWidget();
          },
        ),
        GoRoute(
          path: '/list',
          builder: (context, state) => const MyWidgetList(),
        ),
        GoRoute(
          path: '/details/:userId',
          builder: (context, state) {
            final userId = state.pathParameters['userId'];
            return GetUserDetails(userId: userId.toString());
          },
        ),
        GoRoute(
          path: '/create',
          builder: (context, state) => const CreateForm(),
        ),
        GoRoute(
          path: '/update/:userId',
          builder: (context, state) {
            final userId = state.pathParameters['userId'];
            return UpdateForm(userId: userId.toString());
          },
        ),
      ],
    );

    return MaterialApp(
      home: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
