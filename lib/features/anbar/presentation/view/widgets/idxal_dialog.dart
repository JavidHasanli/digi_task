import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IdxalDialog extends StatefulWidget {
  final int? itemId;
  final VoidCallback onUpdate;

  const IdxalDialog({super.key, this.itemId, required this.onUpdate});

  @override
  State<IdxalDialog> createState() => _IdxalDialogState();
}

class _IdxalDialogState extends State<IdxalDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final Dio _dio = Dio();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<void> _submitData() async {
    final data = {
      'item_id': widget.itemId.toString(),
      'product_provider': _providerController.text,
      'number': _quantityController.text,
    };

    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        'http://135.181.42.192/services/increment_import/',
        data: data,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Məlumatlar uğurla yeniləndi')),
        );
        widget.onUpdate;
      } else {
        throw Exception('Məlumatı təqdim etmək alınmadı');
      }
    } catch (e) {
      print('Error submitting data $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('İdxal'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              TextFormField(
                controller: _providerController,
                decoration: const InputDecoration(
                  labelText: 'Məhsul Təchizatçısı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Sayı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu sahə boş ola bilməz';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              try {
                await _submitData();
                widget.onUpdate();
                Navigator.of(context).pop();
              } catch (e) {
                print('Error: $e');
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: Colors.blue.shade900,
          ),
          child: const Text(
            'İdxal et',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _providerController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
