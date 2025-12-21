import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'settings_dao.g.dart';

/// DAO для работы с настройками (key-value)
@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// Получить значение настройки по ключу
  Future<String?> getValue(String key) async {
    final setting = await (select(
      settings,
    )..where((tbl) => tbl.key.equals(key))).getSingleOrNull();
    return setting?.value;
  }

  Future<bool> getBoolValue(String key) async {
    final value = await getValue(key);
    return value == 'true';
  }

  Future<void> setBoolValue(String key, bool value) async {
    await setValue(key, value ? 'true' : 'false');
  }

  /// Установить значение настройки
  Future<void> setValue(String key, String value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: Value(key),
        value: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Удалить настройку
  Future<void> deleteValue(String key) async {
    await (delete(settings)..where((tbl) => tbl.key.equals(key))).go();
  }

  /// Получить все настройки
  Future<Map<String, String>> getAllSettings() async {
    final allSettings = await select(settings).get();
    return {for (var setting in allSettings) setting.key: setting.value};
  }
}
