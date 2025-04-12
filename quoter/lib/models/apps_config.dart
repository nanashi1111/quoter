
import 'package:freezed_annotation/freezed_annotation.dart';
part 'apps_config.freezed.dart';
part 'apps_config.g.dart';

@freezed
class AppsConfig with _$AppsConfig {
  const factory AppsConfig({
    @JsonKey(name: "package_name")
    required String packageName,
    @JsonKey(name: "purchase_enabled")
    required bool purchaseEnabled,
  }) = _AppsConfig;

  factory AppsConfig.fromJson(Map<String, dynamic> json) =>
      _$AppsConfigFromJson(json);
}
