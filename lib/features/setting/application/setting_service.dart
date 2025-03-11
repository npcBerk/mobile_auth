import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_auth/features/setting/application/isetting_service.dart';
import 'package:mobile_auth/features/setting/data/repository/isetting_repository.dart';
import 'package:mobile_auth/features/setting/data/repository/setting_repository.dart';

final settingServiceProvider = Provider<ISettingService>((ref) {
  final settingRepository = ref.watch(settingRepositoryProvider);
  return SettingService(settingRepository);
});

class SettingService implements ISettingService {
  final ISettingRepository _settingRepository;

  SettingService(this._settingRepository);

  @override
  Future<void> logout() async {
    _settingRepository.clearToken();
  }
}
