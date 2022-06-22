

import 'package:bloc/bloc.dart';
import 'package:exams_app/features/login/domain/use_cases/lang_use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/app_strings.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LangUseCases langUseCases;

  LocaleCubit({required this.langUseCases}) :
        super(const ChangeLocaleState(Locale(AppStrings.englishCode)));


  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await langUseCases.getSavedLang();
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await langUseCases.changeLang(langCode);

    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => _changeLang(AppStrings.englishCode);

  void toArabic() => _changeLang(AppStrings.arabicCode);
}
