import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_mix_in/todo/event.dart';
import 'package:riverpod_mix_in/todo/state.dart';
import 'package:riverpod_mix_in/todo/todo.dart';

void main() {
  final homeStates = HomeStateTest();
  final homeEvents = HomeEventsTest();

  // 例1
  test('Add todo', () {
    final container = ProviderContainer();
    homeEvents.addTodo(container, 'test');
    expect(container.read(todoListProvider).length, 1);
    expect(container.read(todoListProvider).first.title, 'test');

    homeEvents.addTodo(container, 'test2');
    expect(container.read(todoListProvider).length, 2);

    homeEvents.removeTodoAt(container, 0);
    expect(container.read(todoListProvider).length, 1);
    expect(container.read(todoListProvider).first.title, 'test2');
  });

  //例2
  test('search todo', () async {
    final container = ProviderContainer(
        // 必要に応じてProviderのoverrideを行うことも可能
        );

    // 初期Todoを追加
    homeEvents.addTodo(container, 'test');
    expect(container.read(todoListProvider).length, 1);
    expect(container.read(todoListProvider).first.title, 'test');

    // 検索用のテキストを入力
    homeStates.textController(container).text = 'test';
    expect(homeStates.textController(container).text, 'test');

    // 検索実行
    homeEvents.search(container);

    // 初期ステートはLoading
    expect(
      homeStates.searchedTodo(container),
      const AsyncValue<List<Todo>>.loading(),
    );

    // 検索中の状態が適切に反映される
    expect(homeStates.isSearching(container), true);

    // 検索結果が正常に反映される
    await Future.delayed(const Duration(seconds: 1));
    expect(homeStates.searchedTodo(container).value, [
      isA<Todo>().having((e) => e.title, 'title', 'test'),
    ]);
  });
}
