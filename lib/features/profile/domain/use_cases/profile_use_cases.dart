import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:exams_app/features/profile/domain/repositories/profile_repository.dart';

abstract class ProfileUseCases {

  Future<Either<Failure, UserDetails>> getUserById(int userId);

  Future<Either<Failure, UserDetails>> changePassword(int userId, String newPassword);

  Future<Either<Failure, UserDetails>> changeUsername(int userId, String newUsername);


}


class ProfileUseCasesImpl implements ProfileUseCases {

  final ProfileRepository profileRepository;

  ProfileUseCasesImpl({required this.profileRepository});

  @override
  Future<Either<Failure, UserDetails>> changePassword(int userId, String newPassword) {

    return profileRepository.changePassword(userId, newPassword);
  }

  @override
  Future<Either<Failure, UserDetails>> changeUsername(int userId, String newUsername) {
    return profileRepository.changeUsername(userId, newUsername);
  }

  @override
  Future<Either<Failure, UserDetails>> getUserById(int userId) {
    return profileRepository.getUserById(userId);
  }


}

