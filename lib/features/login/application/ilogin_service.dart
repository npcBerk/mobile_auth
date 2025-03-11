import 'package:mobile_auth/features/login/data/dto/request/login_request.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:mobile_auth/common/exception/failure.dart';

abstract interface class ILoginService {
  Future<Result<bool, Failure>> login(LoginRequest loginRequest);
}
