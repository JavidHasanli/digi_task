import 'package:bloc/bloc.dart';

class NotificationCubit extends Cubit<int> {
  NotificationCubit() : super(0);

  void setNotificationCount(int count) {
    emit(count);
  }

  void incrementNotificationCount() {
    emit(state + 1);
  }

  void clearNotifications() {
    emit(0);
  }

  void loadInitialNotificationCount(List<Map<String, String>> initialNotifications) {
    emit(initialNotifications.length);
    print("Notification count updated to: $state");
  }
}
