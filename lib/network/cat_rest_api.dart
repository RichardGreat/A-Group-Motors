import 'package:agroup_motors/entity/cat_fact.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cat_rest_api.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com")
abstract class CatRestApi {
  factory CatRestApi(Dio dio, {String baseUrl}) = _CatRestApi;

  @GET("/facts/random?animal_type=cat")
  Future<CatFact> getRandomFact();
}
