import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo.g.dart';

class Todo {
  final String title;
  const Todo(this.title);
}

class Memo {
  final String title;
  const Memo(this.title);
}

@riverpod
class MemoState extends _$MemoState {
  @override
  List<Memo> build() => [];

  void add(String title) {
    state = [...state, Memo(title)];
  }

  void removeAt(int index) {
    state = [...state]..removeAt(index);
  }

  Future<List<Memo>> search(String searchWord) async {
    await Future.delayed(const Duration(seconds: 1)); // 疑似的な処理時間
    return state
        .where((element) => element.title.contains(searchWord))
        .toList();
  }
}

// @freezed
// class TodoState with _$TodoState {

//   const factory TodoState({
//     required List<Todo> todoList,
//     required TextEditingController  textController,
//     required bool isSearching,
//     required String searchWord,

//   }) = _TodoState;

//   // json形式で受け取るためのコードを生成するために記述
//   factory TodoState.fromJson(Map<String, dynamic> json) => _$TodoStateFromJson(json);
// }