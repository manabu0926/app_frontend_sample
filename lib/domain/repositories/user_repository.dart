import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/config/const/theme_setting.dart';
import 'package:front/domain/custom_exception.dart';
import 'package:front/domain/models/user/user.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// 抽象クラスを定義
abstract class BaseUserRepository {
  Future<User>? getCurrentUser(String idToken);
  Future<List<dynamic>> getUsers();
  void addUser();
}

// 認証リポジトリクラス
class UserRepository implements BaseUserRepository {
  Dio dio = Dio(ThemeSetting.baseOptions);
  final baseUserUrl = "${dotenv.env['BASE_URL']}/users";

  @override
  Future<User> getCurrentUser(String idToken) async {
    try {
      String url = '$baseUserUrl/current';
      final options = Options(headers: {'authorization': 'Bearer $idToken'});
      final Map<String, dynamic> result = (await dio.get(url, options: options)).data;
      return User.fromJson(result);
    } on DioError catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<dynamic>> getUsers() async {
    try {
      var result = await dio.get(baseUserUrl);
      return result.data;
    } on DioError catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<int?> addUser() async {
    try {
      var result = await dio.post(baseUserUrl);
      return result.statusCode;
    } on DioError catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      throw CustomException(message: e.message);
    }
  }
}
