import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/data/services/network/auth_service.dart';
import 'package:digi_task/features/isciler/models/user_model.dart';
import 'package:digi_task/features/isciler/widgets/delete_dialog.dart';
import 'package:digi_task/features/isciler/widgets/edit_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IscilerView extends StatefulWidget {
  const IscilerView({super.key});

  @override
  _IscilerViewState createState() => _IscilerViewState();
}

class _IscilerViewState extends State<IscilerView> {
  late Future<List<User>> _usersFuture;
  late Future<List<String>> _userTypesFuture;
  late Future<List<String>> _groupsFuture;
  final AuthService authService = AuthService();
  final SecureService secureService =
      SecureService(secureStorage: const FlutterSecureStorage());

  String? _selectedUserType;
  String? _selectedGroup;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchUsers();
    _userTypesFuture = _fetchUserTypes();
    _groupsFuture = _fetchGroups();
  }

  Future<List<User>> _fetchUsers() async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await Dio().get(
        'http://135.181.42.192/accounts/users',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        List<User> users =
            (response.data as List).map((user) => User.fromJson(user)).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await Dio().delete(
        'http://135.181.42.192/accounts/delete_user/$userId/',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 204) {
        setState(() {
          _usersFuture = _fetchUsers();
        });
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<List<String>> _fetchUserTypes() async {
    return [
      'Bütün işçilər',
      'Texnik',
      'Texnik menecer',
      'Plumber',
      'Ofis menecer'
    ];
  }

  Future<List<String>> _fetchGroups() async {
    return ['Bütün qruplar', 'Qrup 1', 'Qrup 2'];
  }

  List<User> _filterUsers(List<User> users) {
    if (_selectedUserType != null && _selectedUserType != 'Bütün işçilər') {
      users =
          users.where((user) => user.userType == _selectedUserType).toList();
    }
    if (_selectedGroup != null && _selectedGroup != 'Bütün qruplar') {
      users =
          users.where((user) => user.group?.group == _selectedGroup).toList();
    }
    return users;
  }

  void _refreshUserData() {
    setState(() {
      _usersFuture = _fetchUsers(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
        ),
        title: const Text('İşçilər'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vəzifələr:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      FutureBuilder<List<String>>(
                        future: _userTypesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.data!.isEmpty) {
                            return const Text('No user types found');
                          } else {
                            return DropdownButtonFormField<String>(
                              value: _selectedUserType,
                              decoration: const InputDecoration(
                                hintText: 'Bütün işçilər',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUserType = newValue;
                                });
                              },
                              items: snapshot.data!.map((String userType) {
                                return DropdownMenuItem<String>(
                                  value: userType,
                                  child: Text(
                                    userType,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qrup:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      FutureBuilder<List<String>>(
                        future: _groupsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.data!.isEmpty) {
                            return const Text('No groups found');
                          } else {
                            return DropdownButtonFormField<String>(
                              value: _selectedGroup,
                              decoration: const InputDecoration(
                                hintText: 'Bütün qruplar',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGroup = newValue;
                                });
                              },
                              items: snapshot.data!.map((String group) {
                                return DropdownMenuItem<String>(
                                  value: group,
                                  child: Text(
                                    group,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF2B75CC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _selectedUserType ?? 'Bütün işçilər',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No users found'));
                } else {
                  List<User> filteredUsers = _filterUsers(snapshot.data!);
                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email),
                          trailing: PopupMenuButton<String>(
                            onSelected: (String value) async {
                              if (value == 'edit') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditUserDialog(
                                      user: user,
                                      onUserUpdated: _refreshUserData,
                                    );
                                  },
                                );
                              } else if (value == 'delete') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteConfirmationDialog(
                                      onConfirm: () {
                                        _deleteUser(user.id);
                                      },
                                    );
                                  },
                                );
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    SizedBox(width: 5),
                                    Text('Redaktə et'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outlined),
                                    SizedBox(width: 5),
                                    Text('Sil'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
