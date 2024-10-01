import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:zini_pay_task/src/core/error/failure.dart';

import '../models/message_model.dart';

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio});

  Future<Either<Failure, T>> get<T>(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return Right(response.data as T);
      } else {
        return const Left(ServerFailure());
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return const Left(ConnectTimeOutFailure());
      } else if (error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const Left(ConnectTimeOutFailure());
      } else if (error.type == DioExceptionType.unknown &&
          error.message!.contains("SocketException")) {
        return const Left(NoInternetConnectionFailure());
      } else {
        return const Left(UnexpectedFailure());
      }
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  Future<Either<Failure, T>> post<T>(String url,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        return Right(response.data as T);
      } else {
        return const Left(ServerFailure());
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return const Left(ConnectTimeOutFailure());
      } else if (error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const Left(ConnectTimeOutFailure());
      } else if (error.type == DioExceptionType.unknown &&
          error.message!.contains("SocketException")) {
        return const Left(NoInternetConnectionFailure());
      } else {
        return const Left(UnexpectedFailure());
      }
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  Future<Either<Failure, dynamic>> syncSms(
      Map<String, dynamic> inputData) async {
    final response = await post(
      'https://demo.zinipay.com/sms/sync',
      data: {
        'message': inputData['message'],
        'from': inputData['from'],
        'timestamp': inputData['timestamp'],
      },
    );

    return response;
  }

  Future<Either<Failure, dynamic>> login(Map<String, dynamic> inputData) async {
    final response = await post(
      'https://demo.zinipay.com/app/auth',
      data: {
        'email': inputData['email'],
        'apiKey': inputData['apiKey'],
      },
    );

    return response;
  }

  Future<Either<Failure, dynamic>> fetchMessages() async {
    final response = await get('https://demo.zinipay.com/sms');
    return response;
  }

  Future<Either<Failure, dynamic>> fetchCredentials() async {
    final response = await get('https://demo.zinipay.com/devices');
    return response;
  }
}
