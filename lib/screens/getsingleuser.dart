import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testriverpod/apicalls/userdetails.dart';
import 'package:testriverpod/drawer.dart';

class GetUserDetails extends ConsumerWidget {
  final String userId;
  const GetUserDetails({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider(userId));
    // debugPrint(userDetails.value?['data'].toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud with Riverpod'),
      ),
      drawer: const Draw(),
      body: Center(
        child: userDetails.when(
          data: (user) {
            // debugPrint(user['data'].toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user['data']['name'].toString()),
                Text(user['data']['username'].toString()),
                Text(user['data']['email'].toString()),
                Text(user['data']['password'].toString()),
                IconButton(
                    onPressed: () {
                      context.go('/');
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            );
            // Render the data when available
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    );
  }
}
