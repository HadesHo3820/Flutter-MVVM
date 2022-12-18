import 'package:counter/data/network/failure.dart';
import 'package:counter/data/request/request.dart';
import 'package:counter/domain/model/model.dart';
import 'package:counter/domain/repository/repository.dart';
import 'package:counter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        countryMobileCode: input.countryMobileCode,
        email: input.email,
        mobileNumber: input.mobileNumber,
        password: input.password,
        profilePicture: input.profilePicture,
        userName: input.userName));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(
      {required this.countryMobileCode,
      required this.userName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.profilePicture});
}
