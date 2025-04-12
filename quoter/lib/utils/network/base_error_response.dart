import 'dart:convert';
BaseErrorResponse baseErrorResponseFromJson(String str) => BaseErrorResponse.fromJson(json.decode(str));
String baseErrorResponseToJson(BaseErrorResponse data) => json.encode(data.toJson());
class BaseErrorResponse {
  BaseErrorResponse({
    ResponseStatus? responseStatus,}){
    _responseStatus = responseStatus;
  }

  BaseErrorResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'] != null ? ResponseStatus.fromJson(json['ResponseStatus']) : null;
  }
  ResponseStatus? _responseStatus;
  BaseErrorResponse copyWith({  ResponseStatus? responseStatus,
  }) => BaseErrorResponse(  responseStatus: responseStatus ?? _responseStatus,
  );
  ResponseStatus? get responseStatus => _responseStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_responseStatus != null) {
      map['ResponseStatus'] = _responseStatus?.toJson();
    }
    return map;
  }

}

ResponseStatus responseStatusFromJson(String str) => ResponseStatus.fromJson(json.decode(str));
String responseStatusToJson(ResponseStatus data) => json.encode(data.toJson());
class ResponseStatus {
  ResponseStatus({
    String? errorCode,
    String? message,
    List<dynamic>? errors,}){
    _errorCode = errorCode;
    _message = message;
  }

  ResponseStatus.fromJson(dynamic json) {
    _errorCode = json['ErrorCode'];
    _message = json['Message'];
  }
  String? _errorCode;
  String? _message;

  ResponseStatus copyWith({  String? errorCode,
    String? message,
    List<dynamic>? errors,
  }) => ResponseStatus(  errorCode: errorCode ?? _errorCode,
    message: message ?? _message,
  );
  String? get errorCode => _errorCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ErrorCode'] = _errorCode;
    map['Message'] = _message;
    return map;
  }

}