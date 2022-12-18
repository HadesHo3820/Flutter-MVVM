import 'package:counter/app/functions.dart';
import 'package:counter/data/network/failure.dart';
import 'package:counter/data/request/request.dart';
import 'package:counter/domain/model/model.dart';
import 'package:counter/domain/repository/repository.dart';
import 'package:counter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        email: input.email,
        password: input.password,
        imei: deviceInfo.identifier,
        deviceType: deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
