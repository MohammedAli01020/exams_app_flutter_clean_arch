import 'package:exams_app/features/login/domain/repositories/lang_repository.dart';

import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class LangUseCases {

  Future<Either<Failure, bool>> changeLang(String langCode);

  Future<Either<Failure, String>> getSavedLang();
}


class LangUseCasesImpl implements LangUseCases {

  final LangRepository langRepository;

  LangUseCasesImpl({required this.langRepository});

  @override
  Future<Either<Failure, bool>> changeLang(String langCode) {

    return langRepository.changeLang(langCode);
  }

  @override
  Future<Either<Failure, String>> getSavedLang() {
    return langRepository.getSavedLang();
  }

}