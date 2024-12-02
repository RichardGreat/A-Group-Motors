import 'package:agroup_motors/bloc/history/bloc.dart';
import 'package:agroup_motors/bloc/history/event.dart';
import 'package:agroup_motors/bloc/history/state.dart';
import 'package:agroup_motors/util/date_util.dart';
import 'package:agroup_motors/widgets/error_widget.dart';
import 'package:agroup_motors/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  static const String routeName = "/history";

  static void open(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facts History'),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          HistoryBloc bloc = context.read<HistoryBloc>();
          bloc.add(LoadHistory());

          if (state is HistoryLoading) {
            return LoadingWidget();
          }

          if (state is HistoryLoaded) {
            return ListView.builder(
              itemCount: state.facts.length,
              itemBuilder: (context, index) {
                final fact = state.facts[index];
                return ListTile(
                  title: Text(fact.text),
                  subtitle: Text(
                    DateUtil.yMMMd.format(fact.createdAt),
                  ),
                );
              },
            );
          }

          if (state is HistoryError) {
            return ErrorStateWidget(
              error: state.message,
              buttonText: 'Try Again',
              onRetry: () => bloc.add(LoadHistory()),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
