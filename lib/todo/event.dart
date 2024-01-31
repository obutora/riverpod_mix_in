import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mix_in/todo/state.dart';
import 'package:riverpod_mix_in/todo/todo.dart';

mixin class HomeEvents {
  void changeSearchingState(WidgetRef ref, bool isSearching) =>
      ref.read(isSearchingProvider.notifier).state = isSearching;

  void clearTextController(WidgetRef ref) {
    changeSearchingState(ref, false);
    ref.read(textControllerProvider).clear();
  }

  void addTodo(WidgetRef ref, String title) {
    changeSearchingState(ref, false);
    ref
        .read(todoListProvider.notifier)
        .update((state) => state = [...state, Todo(title)]);
  }

  void removeTodoAt(WidgetRef ref, int index) {
    changeSearchingState(ref, false);
    ref
        .read(todoListProvider.notifier)
        .update((state) => state = [...state]..removeAt(index));
  }

  void search(WidgetRef ref) {
    changeSearchingState(ref, true);

    final inputText = ref.read(textControllerProvider).text;
    ref.read(searchWordProvider.notifier).state = inputText;
  }
}

// Test用のMixin
// 1. 元のMixinをコピペ
// 2. WidgetRefをProviderContainerに変更
mixin class HomeEventsTest {
  void changeSearchingState(ProviderContainer container, bool isSearching) =>
      container.read(isSearchingProvider.notifier).state = isSearching;

  void clearTextController(ProviderContainer container) {
    changeSearchingState(container, false);
    container.read(textControllerProvider).clear();
  }

  void addTodo(ProviderContainer container, String title) {
    changeSearchingState(container, false);
    container
        .read(todoListProvider.notifier)
        .update((state) => state = [...state, Todo(title)]);
  }

  void removeTodoAt(ProviderContainer container, int index) {
    changeSearchingState(container, false);
    container
        .read(todoListProvider.notifier)
        .update((state) => state = [...state]..removeAt(index));
  }

  void search(ProviderContainer container) {
    changeSearchingState(container, true);

    final inputText = container.read(textControllerProvider).text;
    container.read(searchWordProvider.notifier).state = inputText;
  }
}
