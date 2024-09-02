import 'package:digi_task/features/anbar/domain/repository/anbar_item_repository.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_state.dart';
import 'package:flutter/material.dart';

class AnbarNotifier extends ChangeNotifier {
  AnbarNotifier(this.anbarRepository);
  final AnbarItemRepository anbarRepository;
  AnbarState state = AnbarInitial();

  Future<void> getAnbarItemList() async {
    state = AnbarLoading();
    notifyListeners();
    final anbarItemList = await anbarRepository.getAnbarList();
    if (anbarItemList.isSuccess()) {
      final result = anbarItemList.tryGetSuccess();
      state = AnbarSuccess(anbarList: result!);
      notifyListeners();
    } else if (anbarItemList.isError()) {
      final result = anbarItemList.tryGetError();
      state = AnbarFailure(message: result.toString());
      notifyListeners();
    } else {
      state = AnbarFailure(message: "Unknown error");
      notifyListeners();
    }
  }
}