import 'dart:typed_data';

import '../repository/geocam_repository.dart';

class LoadPhotoUsecase {
  final GeocamRepository repo;

  LoadPhotoUsecase(this.repo);

  Future<Uint8List?> call() => repo.loadPhoto();
}