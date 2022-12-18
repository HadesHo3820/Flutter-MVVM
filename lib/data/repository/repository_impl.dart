import 'dart:developer';

import 'package:counter/data/data_source/remote_data_source.dart';
import 'package:counter/data/mapper/mapper.dart';
import 'package:counter/data/network/error_handler.dart';
import 'package:counter/data/network/failure.dart';
import 'package:counter/data/network/network_info.dart';
import 'package:counter/data/request/request.dart';
import 'package:counter/domain/model/model.dart';
import 'package:counter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // it's safe to call the API
        log("response status");
        final response = await _remoteDataSource.login(loginRequest);
        log("response status: ${response.status}");
        if (response.status == ApiInternalStatus.success) {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(
              code: response.status ?? ApiInternalStatus.failure,
              message: response.message ?? ResponseMessage.defaults));
        }
      } catch (error) {
        log("err occurs, ${error.toString()}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        // It's safe to call API
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.success) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          //failure
          //return left
          return Left(Failure(
              code: response.status ?? ResponseCode.defaults,
              message: response.message ?? ResponseMessage.defaults));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return network connection error
      //return Left
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // it's safe to call the API
        log("response status");
        final response = await _remoteDataSource.register(registerRequest);
        log("response status: ${response.status}");
        if (response.status == ApiInternalStatus.success) {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(
              code: response.status ?? ApiInternalStatus.failure,
              message: response.message ?? ResponseMessage.defaults));
        }
      } catch (error) {
        log("err occurs, ${error.toString()}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
