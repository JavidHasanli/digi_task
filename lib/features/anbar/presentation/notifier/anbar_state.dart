
import 'package:equatable/equatable.dart';

import '../../data/model/anbar_item_model.dart';

abstract class AnbarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnbarInitial extends AnbarState {}

class AnbarLoading extends AnbarState {}

class AnbarSuccess extends AnbarState {
  final List<AnbarItemModel> anbarList;
  AnbarSuccess({required this.anbarList});

  @override
  List<Object?> get props => [anbarList];
}

class AnbarFailure extends AnbarState {
  final String message;
  AnbarFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
