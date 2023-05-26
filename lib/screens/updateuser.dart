import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testriverpod/apicalls/userdetails.dart';
import 'package:testriverpod/apicalls/userupdate.dart';
import 'package:testriverpod/drawer.dart';
import 'package:testriverpod/models/users.dart';

class UpdateForm extends ConsumerStatefulWidget {
  final String userId;
  const UpdateForm({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateFormState();
}

class _CreateFormState extends ConsumerState<UpdateForm> {
  late UserModel user;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = UserModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final checkState = ref.watch(putRequestProvider);
    final userDetails = ref.watch(userDetailsProvider(widget.userId));
    // debugPrint(checkState.data.toString());
    // debugPrint(userDetails.value?['data'].toString());
    final initialName = userDetails.value?['data']['name'].toString();
    final initialEmail = userDetails.value?['data']['email'].toString();
    final initialUsername = userDetails.value?['data']['username'].toString();
    final initialPassword = userDetails.value?['data']['password'].toString();
    // debugPrint(initialName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud with Riverpod'),
      ),
      drawer: const Draw(),
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              checkState.isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
              checkState.error != ''
                  ? Text(checkState.error.toString())
                  : const SizedBox.shrink(),
              checkState.error == ''
                  ? Text(checkState.data['message'].toString())
                  : const SizedBox.shrink(),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your Name',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: TextEditingController(text: initialName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                },
                onSaved: (value) {
                  user = user.copyWith(name: value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: TextEditingController(text: initialEmail),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                },
                onSaved: (value) {
                  user = user.copyWith(email: value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your username',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                },
                controller: TextEditingController(text: initialUsername),
                onSaved: (value) {
                  user = user.copyWith(username: value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: TextEditingController(text: initialPassword),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                },
                onSaved: (value) {
                  user = user.copyWith(password: value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    ref
                        .read(putRequestProvider.notifier)
                        .performPutRequest(user.toJson(), widget.userId);
                    ref.invalidate(userDetailsProvider);
                  }
                },
                child: const Text('update'),
              ),
              IconButton(
                  onPressed: () {
                    context.go('/details/${widget.userId}');
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
        )),
      ),
    );
  }
}
