import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mix_in/todo/event.dart';
import 'package:riverpod_mix_in/todo/state.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget with HomeState, HomeEvents {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: textController(ref),
                      decoration: const InputDecoration(
                        labelText: 'input todo',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      clearTextController(ref);
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () => addTodo(ref, textController(ref).text),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('Search'),
                      onPressed: () => search(ref),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: todoCount(ref),
                  itemBuilder: (context, index) {
                    final todo = todoList(ref)[index];
                    return Text(todo.title);
                  },
                ),
              ),
              const Divider(),
              isShowingSearchResult(ref)
                  ? searchedTodo(ref).when(
                      data: (data) => Flexible(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final todo = data[index];
                            return Text(todo.title);
                          },
                        ),
                      ),
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
