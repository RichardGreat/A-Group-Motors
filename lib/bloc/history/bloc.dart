import 'package:agroup_motors/bloc/history/event.dart';
import 'package:agroup_motors/bloc/history/state.dart';
import 'package:agroup_motors/entity/cat_fact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final Box<CatFact> factsBox;

  HistoryBloc({required this.factsBox}) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final facts = factsBox.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      emit(HistoryLoaded(facts));
    } catch (e) {
      emit(HistoryError('Failed to load history: $e'));
    }
  }
}
