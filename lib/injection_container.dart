import 'package:dio/dio.dart';
import 'package:exams_app/features/exams/data/data_sources/exams_remote_data_scource.dart';
import 'package:exams_app/features/exams/data/data_sources/question_remote_data_source.dart';
import 'package:exams_app/features/exams/data/data_sources/user_exam_remote_data_source.dart';
import 'package:exams_app/features/exams/data/repositories/exams_repository_impl.dart';
import 'package:exams_app/features/exams/data/repositories/question_repository_impl.dart';
import 'package:exams_app/features/exams/data/repositories/user_exam_repository_impl.dart';
import 'package:exams_app/features/exams/domain/repositories/exams_repository.dart';
import 'package:exams_app/features/exams/domain/repositories/question_repository.dart';
import 'package:exams_app/features/exams/domain/repositories/user_exam_repository.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';
import 'package:exams_app/features/exams/domain/use_cases/question_use_cases.dart';
import 'package:exams_app/features/exams/domain/use_cases/user_exam_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/exams_cubit.dart';
import 'package:exams_app/features/exams/presentation/cubit/question_cubit.dart';
import 'package:exams_app/features/exams/presentation/cubit/user_exam_cubit.dart';
import 'package:exams_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:exams_app/features/profile/data/repositories/profile_respository_impl.dart';
import 'package:exams_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:exams_app/features/profile/domain/use_cases/profile_use_cases.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'features/login/data/data_sources/login_local_data_scource.dart';
import 'features/login/data/data_sources/login_remote_data_scource.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/use_cases/login_use_cases.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs

  sl.registerFactory(() => LoginCubit(loginUseCases: sl()));
  sl.registerFactory(() => ExamsCubit(examUseCases: sl()));
  sl.registerFactory(() => QuestionCubit(questionUseCases: sl()));
  sl.registerFactory(() => UserExamCubit(userExamUserCases: sl()));

  sl.registerFactory(() => ProfileCubit(profileUseCases: sl(),
      loginUseCases: sl()));



  // Use cases

  sl.registerLazySingleton(() => LoginUseCases(loginRepository: sl()));

  sl.registerLazySingleton<ExamUseCases>(
      () => ExamsUserCasesImpl(examsRepository: sl()));
  sl.registerLazySingleton<QuestionUseCases>(
      () => QuestionUseCasesImpl(questionRepository: sl()));
  sl.registerLazySingleton<UserExamUserCases>(
      () => UserExamUserCasesImpl(userExamRepository: sl()));


  sl.registerLazySingleton<ProfileUseCases>(
          () => ProfileUseCasesImpl(profileRepository: sl()));

  // Repository

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        localDataSource: sl(),
        loginRemoteDataSource: sl(),
    networkInfo: sl(),
      ));

  sl.registerLazySingleton<ExamsRepository>(() =>
      ExamsRepositoryImpl(examsRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<QuestionRepository>(() => QuestionRepositoryImpl(
      questionRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<UserExamRepository>(() => UserExamRepositoryImpl(
      userExamRemoteDataSource: sl(), networkInfo: sl()));


  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
      profileRemoteDataSource: sl(), networkInfo: sl()));

  // Data Sources

  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<ExamsRemoteDataSource>(
      () => ExamsRemoteDataSourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<QuestionRemoteDataSource>(
      () => QuestionRemoteDataSourceImpl(
            apiConsumer: sl(),));

  sl.registerLazySingleton<UserExamRemoteDataSource>(
      () => UserExamRemoteDataSourceImpl(apiConsumer: sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
          () => ProfileRemoteDataSourceImpl(apiConsumer: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
