import 'package:agroup_motors/bloc/home/event.dart';
import 'package:agroup_motors/bloc/home/state.dart';
import 'package:agroup_motors/entity/cat_fact.dart';
import 'package:agroup_motors/network/cat_rest_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CatRestApi catApi;
  final Box<CatFact> factsBox;

  HomeBloc({required this.catApi, required this.factsBox}) : super(HomeInitial()) {
    on<LoadNewFact>(_onLoadNewFact);
  }

  Future<void> _onLoadNewFact(LoadNewFact event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final fact = await catApi.getRandomFact();
      final imageUrl = 'https://cataas.com/cat?t=${DateTime.now().millisecondsSinceEpoch}';
      await factsBox.add(fact);
      emit(HomeLoaded(fact, imageUrl));
    } catch (e) {
      emit(HomeError('Failed to load cat fact: $e'));
    }
  }
}
