import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:digi_task/features/anbar/presentation/view/create/api_service.dart';

class AnbarDialog extends StatefulWidget {
  const AnbarDialog({super.key});

  @override
  State<AnbarDialog> createState() => _AnbarDialogState();
}

class _AnbarDialogState extends State<AnbarDialog> {
  final TextEditingController equipmentNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  TextEditingController? brandController;
  TextEditingController? modelController;
  TextEditingController? macController;
  TextEditingController? portNumberController;
  TextEditingController? serialNumberController;
  TextEditingController? sizeLengthController;

  final ApiService apiService = ApiService();
  String? selectedAnbar;
  int? warehouseId;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    brandController = TextEditingController();
    modelController = TextEditingController();
    macController = TextEditingController();
    portNumberController = TextEditingController();
    serialNumberController = TextEditingController();
    sizeLengthController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      'İdxal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(endIndent: 10, indent: 10),
                  DropdownButtonFormField<String>(
                    value: selectedAnbar,
                    decoration: const InputDecoration(
                      labelText: 'Anbar',
                      border: OutlineInputBorder(),
                    ),
                    items: <Map<String, String>>[
                      {'id': '1', 'name': 'Anbar 1'},
                      {'id': '2', 'name': 'Anbar 2'},
                    ].map((Map<String, String> value) {
                      return DropdownMenuItem<String>(
                        value: value['id'],
                        child: Text(value['name']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAnbar = value;
                        warehouseId = int.tryParse(value!);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu sahə boş ola bilməz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: equipmentNameController,
                          decoration: const InputDecoration(
                            labelText: 'Avadanlığın adı',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bu sahə boş ola bilməz';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: brandController,
                          decoration: const InputDecoration(
                            labelText: 'Marka',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: modelController,
                          decoration: const InputDecoration(
                            labelText: 'Model',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: macController,
                          decoration: const InputDecoration(
                            labelText: 'Mac',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: portNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Port sayı',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: serialNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Seriya nömrəsi',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: sizeLengthController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Ölçüsü',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final item = AnbarItemModel(
                          equipmentName: equipmentNameController.text,
                          brand: brandController?.text ?? '',
                          model: modelController?.text ?? '',
                          mac: macController?.text ?? '',
                          portNumber:
                              int.tryParse(portNumberController?.text ?? '') ??
                                  0,
                          serialNumber: serialNumberController?.text ?? '',
                          number: int.tryParse(numberController.text) ?? 0,
                          sizeLength: sizeLengthController?.text ?? '',
                          warehouse: warehouseId,
                        );

                        try {
                          await apiService.postAnbarItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('İdxal uğurla tamamlandı'),
                            ),
                          );
                          Navigator.of(context).pop();

                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Text('Xəta: ${e.toString()}'),
                            ),
                          );
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
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    equipmentNameController.dispose();
    numberController.dispose();
    brandController?.dispose();
    modelController?.dispose();
    macController?.dispose();
    portNumberController?.dispose();
    serialNumberController?.dispose();
    sizeLengthController?.dispose();
    super.dispose();
  }
}


