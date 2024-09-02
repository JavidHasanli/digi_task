import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/features/isciler/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditUserDialog extends StatefulWidget {
  final User user;
  final VoidCallback onUserUpdated;

  const EditUserDialog(
      {super.key, required this.user, required this.onUserUpdated});

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  String? _selectedUserType;
  String? _selectedGroup;

  final List<String> _userTypes = [
    'Texnik',
    'Texnik menecer',
    'Plumber',
    'Ofis menecer'
  ];
  final List<String> _groups = ['Qrup 1', 'Qrup 2'];

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user.email);
    _usernameController = TextEditingController(text: widget.user.username);
    _phoneController = TextEditingController(text: widget.user.phone);
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _selectedUserType = widget.user.userType;
    _selectedGroup = widget.user.group?.group;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    final token =
        await SecureService(secureStorage: const FlutterSecureStorage())
            .accessToken;
    if (token == null) {
      throw Exception('No access token found');
    }

    var dio = Dio();
    final response = await dio.put(
      'http://135.181.42.192/accounts/update_user/${widget.user.id}/',
      data: {
        'id': widget.user.id,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'user_type': _selectedUserType,
        'username': _usernameController.text,
        'group': _selectedGroup,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('İstifadəçi məlumatlarını yeniləndi')));
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('İstifadəçi məlumatlarını yenilə'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Bu hissə boş ola bilməz',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          labelText: 'İstifadəçi adı',
                          border: OutlineInputBorder()),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Bu hissə boş ola bilməz',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+'))
                      ],
                      decoration: const InputDecoration(
                          labelText: 'Nömrə', border: OutlineInputBorder()),
                      validator: (value) => value != null && value.isNotEmpty
                          ? null
                          : 'Bu hissə boş ola bilməz',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUserType,
                      decoration: const InputDecoration(
                          labelText: 'İstifadəçi tipi',
                          border: OutlineInputBorder()),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUserType = newValue;
                        });
                      },
                      items: _userTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGroup,
                decoration: const InputDecoration(
                    labelText: 'Qrup', border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGroup = newValue;
                  });
                },
                items: _groups.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('İmtina'),
          onPressed: () => Navigator.of(context ).pop(),
        ),
        TextButton(
          child: const Text('Yenilə'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await _updateUser();
                widget.onUserUpdated();
                Navigator.of(context).pop();
              } catch (e) {
                print('Error: $e');
              }
            }
          },
        ),
      ],
    );
  }
}
