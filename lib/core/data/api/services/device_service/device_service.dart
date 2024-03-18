abstract class DeviceService {
  /// Unlink the user's current device.
  Future<bool> unlinkDevice(String email);
}
