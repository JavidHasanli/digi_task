import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';

class TaskApi {
  final Dio _dio = Dio();

  Future<TaskModel> fetchTask(int taskId) async {
    try {
      final String url = 'http://135.181.42.192/services/task/$taskId/';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return TaskModel.fromJson(response.data);
      } else {
        throw Exception(
            'Məlumatların gəlməsində problem baş verdi: ${response.statusMessage}');
      }
    } catch (e) {
      String errorMessage =
          'Tapşırığın alınması xətası: Naməlum xəta baş verdi';
      if (e is DioException) {
        if (e.response != null) {
          errorMessage = 'Tapşırığın alınması xətası: ${e.response?.data}';
        }
      }
      throw Exception(errorMessage);
    }
  }

  Future<void> updateTask({
    required BuildContext context,
    required String taskId,
    required String fullName,
    required String registrationNumber,
    required String contactNumber,
    required String location,
    required String status,
    required String note,
    required String date,
    required List<int> groupData,
    required List<String> selectedServices,
    required TaskModel taskData,
    String? startTime,
    String? endTime,
  }) async {
    try {
      final String uri = 'http://135.181.42.192/services/update_task/$taskId/';

      Map<String, dynamic> updateData = {
        "full_name": fullName,
        "registration_number": registrationNumber,
        "contact_number": contactNumber,
        "location": location,
        "status": status,
        "note": note,
        "is_tv": selectedServices.contains('Tv'),
        "is_voice": selectedServices.contains('Voice'),
        "is_internet": selectedServices.contains('Internet'),
        "date": date,
        "group": groupData,
      };

      if (startTime != null && startTime.isNotEmpty) {
        updateData["start_time"] = startTime;
      }

      if (endTime != null && endTime.isNotEmpty) {
        updateData["end_time"] = endTime;
      }

      final response = await _dio.patch(uri, data: updateData);

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tapşırıq uğurla yeniləndi')),
        );
        // Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Yeniləmədə problem baş verdi: ${response.statusMessage}'),
          ),
        );
      }
    } catch (e) {
      String errorMessage =
          'Tapşırığı yeniləyərkən xəta: Naməlum xəta baş verdi';
      if (e is DioException) {
        if (e.response != null) {
          errorMessage = 'Error updating task: ${e.response?.data}';
          print('Error updating task: ${e.response?.data}');
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
