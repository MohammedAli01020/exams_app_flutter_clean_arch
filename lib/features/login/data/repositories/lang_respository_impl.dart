import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/login/data/data_sources/lang_local_data_source.dart';
import 'package:exams_app/features/login/domain/repositories/lang_repository.dart';

import '../../../../core/error/exceptions.dart';

class LangRepositoryImpl implements LangRepository {

  final LangLocalDataSource langLocalDataSource;

  LangRepositoryImpl({required this.langLocalDataSource});
  @override
  Future<Either<Failure, bool>> changeLang(String langCode) async {

    try {
      final langIsChanged =
      await langLocalDataSource.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocalDataSource.getSavedLang();
      return Right(langCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}