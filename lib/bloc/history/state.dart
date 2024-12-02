import 'package:agroup_motors/entity/cat_fact.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<CatFact> facts;

  HistoryLoaded(this.facts);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
