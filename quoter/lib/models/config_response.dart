import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/models/apps_config.dart';
part 'config_response.freezed.dart';
part 'config_response.g.dart';

@freezed
class ConfigResponse with _$ConfigResponse {
  const factory ConfigResponse({
    @JsonKey(name: "apps_config")
    required List<AppsConfig> appsConfig,
  }) = _ConfigResponse;

  factory ConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfigResponseFromJson(json);
}
