
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class LangRepository {

  Future<Either<Failure, bool>> changeLang(String langCode);

  Future<Either<Failure, String>> getSavedLang();
}