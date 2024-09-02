import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ServiceDetailsWidget extends StatefulWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ServiceDetailsWidget({
    super.key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  });

  @override
  _ServiceDetailsWidgetState createState() => _ServiceDetailsWidgetState();
}

class _ServiceDetailsWidgetState extends State<ServiceDetailsWidget> {
  late TaskModel task;
  String selectedServiceType = '';
  Map<String, bool> isEditingMap = {
    'Internet': false,
    'Tv': false,
    'Voice': false,
  };

  @override
  void initState() {
    super.initState();
    task = widget.taskData;
    selectedServiceType = widget.serviceType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (task.internet != null) _buildInternetContainer(task.internet!),
        const SizedBox(height: 16),
        if (task.tv != null) _buildTvContainer(task.tv!),
        const SizedBox(height: 16),
        if (task.voice != null) _buildVoiceContainer(task.voice!),
      ],
    );
  }

  Widget _buildInternetContainer(Internet internetData) {
    return _buildContainer(
      serviceType: 'Internet',
      title: 'Internet anketi',
      data: internetData,
      onSave: () => _updateTaskData('Internet', internetData),
    );
  }

  Widget _buildTvContainer(Tv tvData) {
    return _buildContainer(
      serviceType: 'Tv',
      title: 'TV anketi',
      data: tvData,
      onSave: () => _updateTaskData('Tv', tvData),
    );
  }

  Widget _buildVoiceContainer(Voice voiceData) {
    return _buildContainer(
      serviceType: 'Voice',
      title: 'Voice anketi',
      data: voiceData,
      onSave: () => _updateTaskData('Voice', voiceData),
    );
  }

  Widget _buildContainer({
    required String serviceType,
    required String title,
    required dynamic data,
    required VoidCallback onSave,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isEditingMap[serviceType]! ? Icons.save : Icons.edit_outlined,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    if (isEditingMap[serviceType]!) {
                      onSave();
                    }
                    isEditingMap[serviceType] = !isEditingMap[serviceType]!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetails(data, isEditingMap[serviceType]!),
        ],
      ),
    );
  }

  Widget _buildDetails(dynamic data, bool isEditing) {
    if (data is Internet) {
      return _buildInternetDetails(data, isEditing);
    } else if (data is Tv) {
      return _buildTvDetails(data, isEditing);
    } else if (data is Voice) { 
      return _buildVoiceDetails(data, isEditing);
    }
    return const SizedBox.shrink();
  }

  Widget _buildInternetDetails(Internet internetData, bool isEditing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', internetData.modemSN,
            (value) => internetData.modemSN = value, isEditing),
        _buildDetailRow('Optik Kabel', internetData.optical_cable,
            (value) => internetData.optical_cable = value, isEditing),
        _buildDetailRow('Fast Connector', internetData.fastconnector,
            (value) => internetData.fastconnector = value, isEditing),
        _buildDetailRow('Signal', internetData.siqnal,
            (value) => internetData.siqnal = value, isEditing),
        if (internetData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            internetData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildTvDetails(Tv tvData, bool isEditing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', tvData.modemSN,
            (value) => tvData.modemSN = value, isEditing),
        _buildDetailRow('RG6 Kabel', tvData.rg6Cable,
            (value) => tvData.rg6Cable = value, isEditing),
        _buildDetailRow('F-Connector', tvData.fConnector,
            (value) => tvData.fConnector = value, isEditing),
        _buildDetailRow('Splitter', tvData.splitter,
            (value) => tvData.splitter = value, isEditing),
        if (tvData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            tvData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildVoiceDetails(Voice voiceData, bool isEditing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Modem S/N', voiceData.modemSN,
            (value) => voiceData.modemSN = value, isEditing),
        _buildDetailRow('Home Number', voiceData.homeNumber,
            (value) => voiceData.homeNumber = value, isEditing),
        _buildDetailRow('Password', voiceData.password,
            (value) => voiceData.password = value, isEditing),
        if (voiceData.photoModem != null) ...[
          const SizedBox(height: 16),
          const Text(
            'Modemin arxa fotosu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            voiceData.photoModem!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(String title, String? value,
      ValueChanged<String> onChanged, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: TextFormField(
              initialValue: value ?? '',
              readOnly: !isEditing,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateTaskData(String serviceType, dynamic data) async {
    String url;

    int? serviceId;
    if (serviceType == 'Internet' && data is Internet) {
      serviceId = data.id;
      url = 'http://135.181.42.192/services/update_internet/$serviceId/';
    } else if (serviceType == 'Tv' && data is Tv) {
      serviceId = data.id;
      url = 'http://135.181.42.192/services/update_tv/$serviceId/';
    } else if (serviceType == 'Voice' && data is Voice) {
      serviceId = data.id;
      url = 'http://135.181.42.192/services/update_voice/$serviceId/';
    } else {
      print('Unknown service type: $serviceType');
      return;
    }

    if (serviceId == null) {
      print('No ID found for $serviceType');
      return;
    }

    try {
      print('Sending data to $url');
      print('Data to be updated: $data');

      MultipartFile? photoFile;
      if (data.photoModem != null) {
        if (Uri.tryParse(data.photoModem!)?.hasAbsolutePath ?? false) {
          var fileInfo =
              await DefaultCacheManager().getFileFromCache(data.photoModem!);
          fileInfo ??=
              await DefaultCacheManager().downloadFile(data.photoModem!);
          photoFile = await MultipartFile.fromFile(fileInfo.file.path);
        } else {
          photoFile = await MultipartFile.fromFile(data.photoModem!);
        }
      }

      FormData formData = FormData.fromMap({});

      if (serviceType == 'Internet') {
        formData.fields.addAll({
          if (data.modemSN != null) MapEntry('modem_SN', data.modemSN!),
          if (data.optical_cable != null)
            MapEntry('optical_cable', data.optical_cable!),
          if (data.fastconnector != null)
            MapEntry('fastconnector', data.fastconnector!),
          if (data.siqnal != null) MapEntry('siqnal', data.siqnal!),
        });
      } else if (serviceType == 'Tv') {
        formData.fields.addAll({
          if (data.modemSN != null) MapEntry('modem_SN', data.modemSN!),
          if (data.rg6Cable != null) MapEntry('rg6_cable', data.rg6Cable!),
          if (data.fConnector != null)
            MapEntry('f_connector', data.fConnector!),
          if (data.splitter != null) MapEntry('splitter', data.splitter!),
        });
      } else if (serviceType == 'Voice') {
        formData.fields.addAll({
          if (data.modemSN != null) MapEntry('modem_SN', data.modemSN!),
          if (data.homeNumber != null)
            MapEntry('home_number', data.homeNumber!),
          if (data.password != null) MapEntry('password', data.password!),
        });
      }

      if (photoFile != null) {
        formData.files.add(MapEntry('photo_modem', photoFile));
      }

      print('FormData: ${formData.fields}');

      Response response = await Dio().patch(url, data: formData);

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$serviceType updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update $serviceType: ${response.data}')),
        );
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.response?.data}');
        if (e.response?.statusCode == 404) {
          print('Resource not found. Check taskId.');
        }
      } else {
        print('Error: $e');
      }
    }
  }
}
