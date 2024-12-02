import 'package:agroup_motors/bloc/history/bloc.dart';
import 'package:agroup_motors/bloc/home/bloc.dart';
import 'package:agroup_motors/entity/cat_fact.dart';
import 'package:agroup_motors/network/cat_rest_api.dart';
import 'package:agroup_motors/page/history/history_page.dart';
import 'package:agroup_motors/page/home/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatFactAdapter());

  final dio = Dio();
  dio.interceptors.add(LogInterceptor(
    // Log the request data/body (e.g., POST parameters)
    requestBody: true,

    // Log the response data/body (the actual data returned from API)
    responseBody: true,

    // Optional - defaults to true
    requestHeader: true,
    // HTTP request headers
    responseHeader: true,
    // HTTP response headers
    error: true,
    // Errors if they occur
    request: true,
    logPrint: (Object message) {
      print('Custom log: $message');
    },
  ));
  final catBox = await Hive.openBox<CatFact>('cat_facts');
  final catRestApi = CatRestApi(dio);

  runApp(MyApp(
    catBox: catBox,
    catApi: catRestApi,
  ));
}

class MyApp extends StatelessWidget {
  final Box<CatFact> catBox;
  final CatRestApi catApi;

  const MyApp({required this.catBox, required this.catApi});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts',
      home: BlocProvider(
        create: (context) => HomeBloc(catApi: catApi, factsBox: catBox),
        child: HomePage(),
      ),
      routes: {
        HistoryPage.routeName: (context) {
          return BlocProvider(
            create: (context) => HistoryBloc(factsBox: catBox),
            child: HistoryPage(),
          );
        },
      },
    );
  }
}
