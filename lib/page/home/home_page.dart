import 'package:agroup_motors/bloc/home/bloc.dart';
import 'package:agroup_motors/bloc/home/event.dart';
import 'package:agroup_motors/bloc/home/state.dart';
import 'package:agroup_motors/page/history/history_page.dart';
import 'package:agroup_motors/util/date_util.dart';
import 'package:agroup_motors/widgets/error_widget.dart';
import 'package:agroup_motors/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Facts'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => HistoryPage.open(context),
        child: const Text('Fact history'),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            HomeBloc bloc = context.read<HomeBloc>();
            if (state is HomeInitial) {
              bloc.add(LoadNewFact());
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeLoading) {
              return LoadingWidget();
            }

            if (state is HomeLoaded) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.network(
                          state.imageUrl,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          state.fact.text,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        DateUtil.yMMMd.format(state.fact.createdAt),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => bloc.add(LoadNewFact()),
                        child: const Text('Another fact!'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is HomeError) {
              return ErrorStateWidget(
                error: state.message,
                buttonText: 'Retry',
                onRetry: () => bloc.add(LoadNewFact()),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
