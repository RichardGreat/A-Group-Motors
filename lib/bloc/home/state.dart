import 'package:agroup_motors/entity/cat_fact.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final CatFact fact;
  final String imageUrl;

  HomeLoaded(this.fact, this.imageUrl);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
