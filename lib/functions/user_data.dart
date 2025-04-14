import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserData {
  final String username;
  final String? profileImagePath;
  final DateTime? registrationDate;

  UserData({
    required this.username,
    this.profileImagePath,
    this.registrationDate,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'profileImagePath': profileImagePath,
        'registrationDate': registrationDate?.toIso8601String(), // แปลง DateTime เป็น String
      };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        username: json['username'] ?? '',
        profileImagePath: json['profileImagePath'],
        registrationDate: json['registrationDate'] != null
            ? DateTime.tryParse(json['registrationDate'])
            : null,
      );
}

class UserStorage {
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_data.json');
  }

  static Future<void> saveUserData(UserData data) async {
    final file = await _getLocalFile();
    await file.writeAsString(json.encode(data.toJson()));
  }

  static Future<UserData?> loadUserData() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        return UserData.fromJson(json.decode(contents));
      }
    } catch (e) {
      // คุณสามารถ log error ได้ที่นี่ถ้าต้องการ
    }
    return null;
  }
}
