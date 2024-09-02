import '../../constants/path/image_paths.dart';

extension ImagePathExt on ImagePath {
  String get toPathPng => 'assets/images/im_$name.png';
  String get toPathSvg => 'assets/images/im_$name.svg';
}
