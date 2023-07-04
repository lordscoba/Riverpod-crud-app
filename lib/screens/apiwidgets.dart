import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testriverpod/apicalls/userdelete.dart';
import 'package:testriverpod/drawer.dart';

import '../apicalls/users.dart';

class MyWidget1 extends ConsumerWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud with Riverpod'),
      ),
      drawer: const Draw(),
      body: Consumer(
        builder: (context, watch, _) {
          final jsonData = ref.watch(usersProvider);
          return jsonData.when(
            //data: (data) => Text(data.toString()), // Display the JSON map data
            data: (data) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data['data'].length.toString()),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: data['data'].length,
                      itemBuilder: (context, index) {
                        final user = data['data'][index];
                        return ListTile(
                          title: Text(user['email']),
                          subtitle: Text(user['username']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.go('/details/${user['_id']}');
                                  },
                                  icon: const Icon(Icons.view_list)),
                              IconButton(
                                  onPressed: () {
                                    context.go('/update/${user['_id']}');
                                  },
                                  icon: const Icon(Icons.update)),
                              IconButton(
                                  onPressed: () {
                                    deleteData(user['_id']);
                                    ref.read(usersProvider);
                                    ref.invalidate(usersProvider);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MyWidgetList extends ConsumerWidget {
  const MyWidgetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud with Riverpod'),
      ),
      drawer: const Draw(),
      body: Consumer(
        builder: (context, watch, _) {
          final usersAsyncValue = ref.watch(usersListProvider);

          return usersAsyncValue.when(
            data: (users) {
              // Render the data when available
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.email),
                  );
                },
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
