import 'package:mobile_auth/features/login/data/dto/request/login_request.dart';
import 'package:mobile_auth/features/login/data/dto/response/login_response.dart';

abstract interface class ILoginRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
}
