import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IdxalPage extends StatefulWidget {
  const IdxalPage({super.key});

  @override
  State<IdxalPage> createState() => _IdxalPageState();
}

class _IdxalPageState extends State<IdxalPage> {
  final Dio _dio = Dio();

  Future<List<dynamic>> _fetchData() async {
    final response =
        await _dio.get('http://135.181.42.192/services/increment_history/');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget _buildHeaderText(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.typography.body1SemiBold.copyWith(
            color: context.colors.neutralColor20,
          ),
        ),
      ),
    );
  }

  Widget _buildItemText(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: context.typography.body2SemiBold.copyWith(
            color: context.colors.primaryColor50,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<List<dynamic>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.primaryColor95,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderText('Avadanlıq', flex: 4),
                        
                        _buildHeaderText('Məhsul provayderi', flex: 4),
                        _buildHeaderText('Tarix', flex: 3),
                        _buildHeaderText('Sayı', flex: 2),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];

                      final dateTime = DateTime.parse(item['date']);
                      String formattedDate =
                          DateFormat('MMM d, HH:mm').format(dateTime);

                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildItemText(item['item_equipment_name'] ?? '',
                                  flex: 4),
                              
                              _buildItemText(item['product_provider'] ?? '',
                                  flex: 4),
                              _buildItemText(formattedDate, flex: 3),
                              _buildItemText(item['number'].toString(),
                                  flex: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
