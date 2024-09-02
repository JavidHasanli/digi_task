import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/presentation/pages/chat/chat_details_page.dart';
import 'package:digi_task/shared/widgets/search_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/path/icon_path.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Dio _dio = Dio();
  final TextEditingController searchController = TextEditingController();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );
  List<dynamic> rooms = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchRooms();
  }

  Future<void> _fetchRooms() async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response =
          await _dio.get('http://135.181.42.192/accounts/RoomsApiView/');
      setState(() {
        rooms = response.data;
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('Error submitting export: ${e.response?.statusCode}');
          print('Error data: ${e.response?.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xəta: ${e.response?.data}')),
          );
        } else {
          print('Error submitting export: ${e.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xəta: ${e.message}')),
          );
        }
      } else {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xəta: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRooms = rooms.where((room) {
      final roomName = room['name'].toLowerCase();
      final query = searchQuery.toLowerCase();
      return roomName.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
        ),
        title: Text('Söhbət', style: context.typography.subtitle2Medium),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomSearchBar(
              controller: searchController,
              fillColor: context.colors.neutralColor100,
              hintText: 'Axtar',
              isAnbar: true,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                final room = filteredRooms[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  leading: const SizedBox(
                    width: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.groups_2_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(room['name'],
                      style: const TextStyle(fontSize: 18.0)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailsPage(
                          groupId: room['id'],
                          groupName: room['name'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
