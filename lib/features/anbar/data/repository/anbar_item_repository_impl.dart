import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repository/anbar_item_repository.dart';
import '../service/anbar_network_service.dart';

final class AnbarItemRepositoryImpl implements AnbarItemRepository {
  AnbarItemRepositoryImpl({required this.anbarNetworkService});
  final AnbarNetworkServiceImpl anbarNetworkService;

  @override
  Future<Result<List<AnbarItemModel>, Exception>> getAnbarList() async {
    try {
      final result = await anbarNetworkService.getAnbarList();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
