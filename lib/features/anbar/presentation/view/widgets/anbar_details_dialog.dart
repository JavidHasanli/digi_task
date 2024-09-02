import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:flutter/material.dart';

class AnbarDetailsDialog extends StatefulWidget {
  final AnbarItemModel item;
  final VoidCallback onUpdate;


  const AnbarDetailsDialog({super.key, required this.item, required this.onUpdate});

  @override
  State<AnbarDetailsDialog> createState() => _AnbarDetailsDialogState();
}

class _AnbarDetailsDialogState extends State<AnbarDetailsDialog> {
  Map<int, String> warehouseNames = {
    1: 'Anbar 1',
    2: 'Anbar 2',
  };

  @override
  Widget build(BuildContext context) {
    final warehouseName =
        warehouseNames[widget.item.warehouse ?? 0] ?? 'Unknown';
    return AlertDialog(
      title: const Text('Anbar Detalları'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: warehouseName,
              decoration: const InputDecoration(
                  labelText: 'Anbar', border: OutlineInputBorder()),
              readOnly: true,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.equipmentName,
                    decoration: const InputDecoration(
                        labelText: 'Avadanlıq', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.brand,
                    decoration: const InputDecoration(
                        labelText: 'Marka', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.model,
                    decoration: const InputDecoration(
                        labelText: 'Model', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.mac,
                    decoration: const InputDecoration(
                        labelText: 'Mac', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.portNumber?.toString(),
                    decoration: const InputDecoration(
                        labelText: 'Port sayı', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.serialNumber,
                    decoration: const InputDecoration(
                        labelText: 'Serial sayı', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.number?.toString(),
                    decoration: const InputDecoration(
                        labelText: 'Sayı', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.sizeLength,
                    decoration: const InputDecoration(
                        labelText: 'Ölçüsü', border: OutlineInputBorder()),
                    readOnly: true,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Bağla'),
        ),
      ],
    );
  }
}
