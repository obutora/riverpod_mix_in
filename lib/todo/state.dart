import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mix_in/todo/todo.dart';

final todoListProvider = StateProvider<List<Todo>>((ref) => []);
final isSearchingProvider = StateProvider<bool>((ref) => false);
final searchWordProvider = StateProvider<String>((ref) => '');
final searchedTodoProvider = FutureProvider<List<Todo>>((ref) async {
  await Future.delayed(const Duration(seconds: 1)); // 疑似的な処理時間
  final searchWord = ref.watch(searchWordProvider);
  return ref
      .watch(todoListProvider)
      .where((element) => element.title.contains(searchWord))
      .toList();
});

final textControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);

mixin class HomeState {
  bool isSearching(WidgetRef ref) => ref.watch(isSearchingProvider);

  List<Todo> todoList(WidgetRef ref) => ref.watch(todoListProvider);

  int todoCount(WidgetRef ref) => ref.watch(todoListProvider).length;

  AsyncValue<List<Todo>> searchedTodo(WidgetRef ref) =>
      ref.watch(searchedTodoProvider);

  TextEditingController textController(WidgetRef ref) =>
      ref.watch(textControllerProvider);

  bool isShowingSearchResult(WidgetRef ref) =>
      textController(ref).text.isNotEmpty && isSearching(ref);
}

// Test用のMixin
// 1. 元のMixinをコピペ
// 2. WidgetRefをProviderContainerに変更
mixin class HomeStateTest {
  bool isSearching(ProviderContainer container) =>
      container.read(isSearchingProvider);

  List<Todo> todoList(ProviderContainer container) =>
      container.read(todoListProvider);

  int todoCount(ProviderContainer container) =>
      container.read(todoListProvider).length;

  AsyncValue<List<Todo>> searchedTodo(ProviderContainer container) =>
      container.read(searchedTodoProvider);

  TextEditingController textController(ProviderContainer container) =>
      container.read(textControllerProvider);

  bool isShowingSearchResult(ProviderContainer container) =>
      textController(container).text.isNotEmpty && isSearching(container);
}
