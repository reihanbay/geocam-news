import 'package:geocam_news/features/geocam/domain/repository/geocam_repository.dart';

class ResetDataUsecase {
  final GeocamRepository repo;
  ResetDataUsecase(this.repo);


  Future<bool> call() => repo.clearPhotoLocation();
}