import 'package:digi_task/data/services/jwt/dio_configuration.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';

abstract class AnbarNetworkService {
  Future<List<AnbarItemModel>> getAnbarList();
}

final class AnbarNetworkServiceImpl implements AnbarNetworkService {
  @override
  Future<List<AnbarItemModel>> getAnbarList() async {
    try {
      final response = await baseDio.get('services/warehouse_item/');
      final anbarItem = response.data as List;
      return anbarItem.map((e) => AnbarItemModel.fromJson(e)).toList();
    } catch (e, s) {
      return Error.throwWithStackTrace(e, s);
    }
  }
}
