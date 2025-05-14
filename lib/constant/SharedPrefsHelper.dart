import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _isPunchedInKey = 'isPunchedIn';
  static const String _punchInTimeKey = 'punchInTime';
  static const String _punchOutTimeKey = 'punchOutTime';
  static const String _punchIdKey = 'punchId';

  // Save punch details
  static Future<void> savePunchDetails({
    required bool isPunchedIn,
    required int punchId,
    String? punchInTime,
    String? punchOutTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPunchedInKey, isPunchedIn);
    await prefs.setInt(_punchIdKey, punchId);
    if (punchInTime != null) await prefs.setString(_punchInTimeKey, punchInTime);
    if (punchOutTime != null) await prefs.setString(_punchOutTimeKey, punchOutTime);
  }

  // Load punch details
  static Future<Map<String, dynamic>> loadPunchDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'isPunchedIn': prefs.getBool(_isPunchedInKey) ?? false,
      'punchId': prefs.getInt(_punchIdKey) ?? 0,
      'punchInTime': prefs.getString(_punchInTimeKey) ?? '',
      'punchOutTime': prefs.getString(_punchOutTimeKey) ?? '',
    };
  }
}