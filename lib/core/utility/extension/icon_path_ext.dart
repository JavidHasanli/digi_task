import '../../constants/path/icon_path.dart';

extension IconPathExt on IconPath {
  String get toPathSvg => 'assets/icons/ic_$name.svg';
}
