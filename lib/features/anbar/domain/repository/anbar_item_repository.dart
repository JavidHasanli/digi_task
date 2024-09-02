import 'package:multiple_result/multiple_result.dart';

import '../../data/model/anbar_item_model.dart';

abstract class AnbarItemRepository {
  Future<Result<List<AnbarItemModel>, Exception>> getAnbarList();
}
