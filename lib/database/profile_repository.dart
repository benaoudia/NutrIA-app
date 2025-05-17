import 'dart:convert';
import 'package:nutria/database/database_helper.dart';

class ProfileRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Save all profile data
  Future<void> saveProfileData(Map<String, dynamic> data) async {
    for (var entry in data.entries) {
      if (entry.value != null) {
        final existingData = await _dbHelper.getUserInput(entry.key);
        if (existingData != null) {
          await _dbHelper.updateUserInput(entry.key, entry.value.toString());
        } else {
          await _dbHelper.insertUserInput(entry.key, entry.value.toString());
        }
      }
    }
  }

  // Load all profile data
  Future<Map<String, dynamic>> loadProfileData() async {
    final allData = await _dbHelper.getAllUserInputs();
    final Map<String, dynamic> profileData = {};

    for (var data in allData) {
      final fieldName = data['field_name'] as String;
      final value = data['value'] as String;

      // Convert string values back to their original types
      if (fieldName == 'height' || fieldName == 'weight' || fieldName == 'step') {
        profileData[fieldName] = int.tryParse(value) ?? 0;
      } else if (fieldName == 'birthdate') {
        profileData[fieldName] = DateTime.parse(value);
      } else if (fieldName == 'allergies') {
        profileData[fieldName] = List<String>.from(jsonDecode(value));
      } else {
        profileData[fieldName] = value;
      }
    }

    return profileData;
  }

  // Update a single field
  Future<void> updateField(String fieldName, dynamic value) async {
    final existingData = await _dbHelper.getUserInput(fieldName);
    if (existingData != null) {
      await _dbHelper.updateUserInput(fieldName, value.toString());
    } else {
      await _dbHelper.insertUserInput(fieldName, value.toString());
    }
  }

  // Get a single field
  Future<dynamic> getField(String fieldName) async {
    final data = await _dbHelper.getUserInput(fieldName);
    if (data != null) {
      final value = data['value'] as String;
      
      // Convert string values back to their original types
      if (fieldName == 'height' || fieldName == 'weight' || fieldName == 'step') {
        return int.tryParse(value) ?? 0;
      } else if (fieldName == 'birthdate') {
        return DateTime.parse(value);
      } else if (fieldName == 'allergies') {
        return List<String>.from(jsonDecode(value));
      } else {
        return value;
      }
    }
    return null;
  }
} 