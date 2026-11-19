import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/search_data.dart';

/// "Recent Searches", newest first. App-wide so the list survives leaving
/// and reopening Search (provided above `MaterialApp`).
class SearchHistoryCubit extends Cubit<List<String>> {
  SearchHistoryCubit([List<String> initial = SearchData.recent]) : super(List.unmodifiable(initial));

  static const int maxItems = 10;

  /// Moves `term` to the top (case-insensitive de-duplication).
  void add(String term) {
    final t = term.trim();
    if (t.isEmpty) return;
    final rest = state.where((s) => s.toLowerCase() != t.toLowerCase());
    emit(List.unmodifiable([t, ...rest].take(maxItems)));
  }

  void remove(String term) => emit(List.unmodifiable(state.where((s) => s != term)));

  void clear() => emit(const []);
}
