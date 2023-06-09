import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/test.dart';
import 'package:testriverpod/drawer.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

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
            data: (data) => Text(data.toString()), // Display the JSON map data
            // data: (data) => Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(data['data'].length.toString()),
            //       SizedBox(
            //         height: 400,
            //         child: ListView.builder(
            //           itemCount: data['data'].length,
            //           itemBuilder: (context, index) {
            //             final user = data['data'][index];
            //             return ListTile(
            //               title: Text(user['email']),
            //               subtitle: Text(user['username']),
            //               trailing: Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   IconButton(
            //                       onPressed: () {
            //                         context.go('/details/${user['_id']}');
            //                       },
            //                       icon: const Icon(Icons.view_list)),
            //                   IconButton(
            //                       onPressed: () {
            //                         context.go('/update/${user['_id']}');
            //                       },
            //                       icon: const Icon(Icons.update)),
            //                   IconButton(
            //                       onPressed: () {
            //                         deleteData(user['_id']);
            //                         ref.read(usersProvider);
            //                         ref.invalidate(usersProvider);
            //                       },
            //                       icon: const Icon(Icons.delete)),
            //                 ],
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
