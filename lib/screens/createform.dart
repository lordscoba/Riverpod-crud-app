import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testriverpod/apicalls/usercreate.dart';
import 'package:testriverpod/drawer.dart';
import 'package:testriverpod/models/users.dart';

class CreateForm extends ConsumerStatefulWidget {
  const CreateForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateFormState();
}

class _CreateFormState extends ConsumerState<CreateForm> {
  // late UserModel user;
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
    final checkState = ref.watch(postRequestProvider);
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
                        .read(postRequestProvider.notifier)
                        .performPostRequest(user.toJson());
                  }
                },
                child: const Text('Validate'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
