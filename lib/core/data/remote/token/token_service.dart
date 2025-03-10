import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_auth/common/dtos/refresh_token_response.dart';
import 'package:mobile_auth/core/data/local/secure_storage/isecure_storage.dart';
import 'package:mobile_auth/core/data/local/secure_storage/secure_storage.dart';
import 'package:mobile_auth/core/data/remote/token/itoken_service.dart';

final tokenServiceProvider = Provider.family<ITokenService,Dio>((ref, dio) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenService(secureStorage, dio);
});

class TokenService implements ITokenService {
  final Dio dio;
  final ISecureStorage _secureStorage;

  TokenService(this._secureStorage, this.dio);

  @override
  Future<void> clearToken() async {
    await _secureStorage.delete('access_token');
    await _secureStorage.delete('refresh_token');
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.read('access_token');
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read('refresh_token');
  }

  @override
  Future<RefreshTokenResponse> refreshToken(String? refreshToken) async{
    try {
      final response = await dio.post('/auth/refresh', data: {
        'refreshToken': refreshToken,
      });

      return RefreshTokenResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
    //TODO

    /*
    final response =  await _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {
        "refreshToken": refreshToken
      }
    );

    if (response.statusCode == success) {
      return RefreshTokenResponse.fromJson(response.data ?? {});
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response
      );
     */
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) async {
    await _secureStorage.write('access_token', accessToken);
    await _secureStorage.write('refresh_token', refreshToken);
  }

}
