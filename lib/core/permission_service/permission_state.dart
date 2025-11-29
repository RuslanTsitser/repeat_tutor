// Глобальное состояние для управления запросами разрешений
class PermissionState {
  static bool _isRequestingPermissions = false;

  static bool get isRequestingPermissions => _isRequestingPermissions;

  static void setRequestingPermissions(bool value) {
    _isRequestingPermissions = value;
  }
}
