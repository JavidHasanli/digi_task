import 'package:digi_task/core/constants/app_keys.dart';
import 'package:digi_task/data/model/response/user_task_model.dart';
import 'package:digi_task/data/repository/home_repository.dart';
import 'package:digi_task/data/services/local/shared_service.dart';
import 'package:digi_task/injection.dart';
import 'package:digi_task/notifier/home/main/main_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MainNotifier extends ChangeNotifier {
  MainNotifier(this.homeRepository);
  MainState homeState = MainInitial();
  final IHomeRepository homeRepository;
  final preference = getIt.get<SharedPreferenceService>();
  bool isAdmin = false;
  UserTaskModel? userTaskModel;
  List<Meetings> meetings = [];

  

  Future<void> fetchUserTask() async {
    homeState = MainLoading();
    notifyListeners();
    final result = await homeRepository.fetchUserTaskData();

    if (result.isSuccess()) {
      userTaskModel = result.tryGetSuccess();
      homeState = MainSuccess(taskDetails: userTaskModel?.taskDetails);
      notifyListeners();
    } else if (result.isError()) {
      homeState = MainError();
      notifyListeners();
    } else {
      homeState = MainError();
      notifyListeners();
    }
  }

  Future<void> fetchMeetings() async {
    final response =
        await Dio().get('http://135.181.42.192/services/meetings/');
    if (response.statusCode == 200) {
      meetings =
          (response.data as List).map((e) => Meetings.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load meetings');
    }
  }

  void checkAdmin() {
    isAdmin = preference.readBool(AppKeys.isAdmin) ?? false;
    print(isAdmin);
    notifyListeners();
  }

}
