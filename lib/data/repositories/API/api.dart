import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  Dio dio = Dio();

  API() {
    dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => dio;
}
