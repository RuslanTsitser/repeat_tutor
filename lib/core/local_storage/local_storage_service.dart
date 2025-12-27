import 'local_storage_service_impl.dart';

abstract interface class LocalStorageService {
  Future<void> init();

  factory LocalStorageService.impl() = LocalStorageServiceImpl;

  Future<T?> getValue<T>(String key);

  Future<void> setValue<T>(String key, T value);

  Future<void> deleteValue(String key);

  Future<void> clear();
}
