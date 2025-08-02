import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class ParseError extends Equatable {
  final String code;
  final String message;
  const ParseError({
    required this.code,
    required this.message,
  });
  @override
  List<Object> get props => [code, message];

  static ParseError fromJson(dynamic error) {
    String code = '-1';
    String message = 'key_unHandle_error'.tr();
    DataError dataError;
    if (error is PlatformException) {
      if (error.code == 'NOT_CONNECTED') {
        return ParseError(
          code: error.code,
          message: 'key_network_connect'.tr(),
        );
      }

      if (error.message != null) {
        code = error.code;
        message = error.message!;
      }
    } else if (error is DioException) {
      code = error.response?.statusCode?.toString() ?? '';
      if (error.response?.data is Map) {
        dataError = DataError.fromJson(error.response!.data);
        code = dataError.rCode;
        message = dataError.rMessage;
      } else {
        switch (code) {
          case '503':
            message = '${'key_service_503'.tr()} (503)';
          case '404':
            message = '${'key_api_not_found'.tr()} (404)';
          case '500':
          case '502':
            message = '${'key_service_error'.tr()} ($code)';
          default:
            message = error.message ?? 'key_unHandle_error'.tr();
        }
      }
    } else {
      if (error is Map) {
        dataError = DataError.fromJson(error);
        code = dataError.rCode;
        message = dataError.rMessage;
      } else {
        message = error.toString();
      }
    }

    return ParseError(
      code: code,
      message: message,
    );
  }
}

class DataError extends Equatable {
  final String rCode;
  final String rMessage;

  const DataError({required this.rCode, required this.rMessage});

  @override
  List<Object?> get props => [rCode, rMessage];

  static DataError fromJson(dynamic json) {
    return DataError(
      rCode: json['code'],
      rMessage: json['message'] == null
          ? 'key_unHandle_error'.tr()
          : json['message'] is String
              ? json['message']
              : jsonEncode(json['message']),
    );
  }
}
