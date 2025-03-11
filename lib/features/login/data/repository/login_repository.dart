import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_auth/common/exception/failure.dart';
import 'package:mobile_auth/common/extension/string_hardcoded.dart';
import 'package:mobile_auth/common/mixin/dio_exception_mapper.dart';
import 'package:mobile_auth/features/login/data/dto/request/login_request.dart';
import 'package:mobile_auth/features/login/data/dto/response/login_response.dart';
import 'package:mobile_auth/features/login/data/repository/ilogin_repository.dart';
import 'package:mobile_auth/features/login/data/source/local/itoken_storage.dart';
import 'package:mobile_auth/features/login/data/source/local/token_storage.dart';
import 'package:mobile_auth/features/login/data/source/remote/login_api.dart';

final loginRepositoryProvider = Provider.autoDispose<ILoginRepository>((ref) {
  final loginApi = ref.watch(loginApiProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);

  return LoginRepository(loginApi, tokenStorage);
});

final class LoginRepository
    with DioExceptionMapper
    implements ILoginRepository {
  final LoginApi _loginApi;
  final ITokenStorage _tokenStorage;

  LoginRepository(this._loginApi, this._tokenStorage);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      // api call
      final response = await _loginApi.login(loginRequest);
      // get access token and refresh token from response
      final accessToken = response.accessToken;
      final refreshToken = response.refreshToken;
      // store in secure storage
      await _tokenStorage.storeToken(accessToken, refreshToken);

      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message:
            "An unexpected error occurred. Please try again later".hardcoded,
        exception: e as Exception,
        stackTrace: s,
      );
    }
  }
}
