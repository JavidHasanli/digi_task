import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/task_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class CreateProblem extends StatefulWidget {
  final String serviceType;
  final int taskId;

  const CreateProblem(
      {super.key, required this.serviceType, required this.taskId});

  @override
  State<CreateProblem> createState() => _CreateProblemState();
}

class _CreateProblemState extends State<CreateProblem> {
  XFile? imageFile;
  final TextEditingController modemSnController = TextEditingController();
  final TextEditingController rg6KabelController = TextEditingController();
  final TextEditingController fConnectorController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController splitterController = TextEditingController();
  final TextEditingController homeNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController opticalCableController = TextEditingController();
  final TextEditingController fastConnectorController = TextEditingController();
  final TextEditingController signalController = TextEditingController();

  final Dio dio = Dio();

  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    fetchTaskAndUpdate();
  }

  void fetchTaskAndUpdate() async {
    try {
      TaskModel task = await _taskService.fetchTask(widget.taskId);
      if (task.id != null) {
        noteController.text = task.id.toString();
      }
    } catch (e) {
      print('Error fetching task: $e');
    }
  }

  void getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = pickedImage;
        });
      }
    } catch (e) {
      setState(() {
        imageFile = null;
      });
      print(e);
    }
  }

  void saveProblem() async {
    try {
      String url = '';
      Map<String, dynamic> data = {
        'modem_SN': modemSnController.text,
        'task': noteController.text,
      };

      if (widget.serviceType == 'Voice') {
        url = 'http://135.181.42.192/services/create_voice/';
        data.addAll({
          'home_number': homeNumberController.text,
          'password': passwordController.text,
        });
      } else if (widget.serviceType == 'Internet') {
        url = 'http://135.181.42.192/services/create_internet/';
        data.addAll({
          'optical_cable': opticalCableController.text,
          'fastconnector': fastConnectorController.text,
          'siqnal': signalController.text,
        });
      } else if (widget.serviceType == 'Tv') {
        url = 'http://135.181.42.192/services/create_tv/';
        data.addAll({
          'rg6_cable': rg6KabelController.text,
          'f_connector': fConnectorController.text,
          'splitter': splitterController.text,
        });
      }

      if (imageFile != null) {
        data['photo_modem'] = await MultipartFile.fromFile(imageFile!.path);
      }

      FormData formData = FormData.fromMap(data);

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Problem uğurla yadda saxlandı')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Xəta baş verdi: ${response.statusCode}: ${response.statusMessage}',
            ),
          ),
        );
      }
    } catch (e) {
      if (e is DioError) {
        print('Error response data: ${e.response?.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xəta baş verdi: ${e.response?.data}')),
        );
      } else {
        print('Xəta: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xəta baş verdi: $e')),
        );
      }
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Problem anketi'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Servis məlumatları',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.serviceType,
                    style: const TextStyle(
                      color: Color(0xFF005ABF),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Modemin arxa fotosu',
                style: TextStyle(fontSize: 16.0, color: Color(0xFF909094)),
              ),
              const SizedBox(height: 8.0),
              imageFile == null
                  ? _buildImagePickerContainer()
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(imageFile!.path),
                            width: double.infinity,
                            height: 100.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          right: 0.0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                imageFile = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 8.0),
              _buildTextFormField('Modem S/N', modemSnController),
              if (widget.serviceType == 'Voice') ...[
                _buildTextFormField('Home Number', homeNumberController),
                _buildTextFormField('Password', passwordController),
              ] else if (widget.serviceType == 'Internet') ...[
                _buildTextFormField('Optical Cable', opticalCableController),
                _buildTextFormField('Fast Connector', fastConnectorController),
                _buildTextFormField('Signal', signalController),
              ] else if (widget.serviceType == 'Tv') ...[
                Row(
                  children: [
                    Expanded(
                      child:
                          _buildTextFormField('RG6 Kabel', rg6KabelController),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildTextFormField(
                          'F-Connector', fConnectorController),
                    ),
                  ],
                ),
                _buildTextFormField('Splitter', splitterController),
              ],
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveProblem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005ABF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Yadda saxla',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller,
      {int maxLines = 1, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, color: Color(0xFF909094)),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(174, 247, 245, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildImagePickerContainer() {
    return GestureDetector(
      onTap: () => getImage(),
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Yükləmək üçün klikləyin',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '(Maksimum fayl ölçüsü: 25 MB)',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Icon(Icons.upload_file_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
