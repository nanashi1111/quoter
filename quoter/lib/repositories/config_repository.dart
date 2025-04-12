
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/models/config_response.dart';
import 'package:quoter/utils/network/http_client_helper.dart';

class ConfigRepository {
  ConfigRepository._internal();

  static final ConfigRepository instance = ConfigRepository._internal();

  Future<bool> isPurchaseEnabled() async {
    try {
      DioClient client = DioClient();
      final response = await client.get('purchase_config.json', authRequired: false);
      ConfigResponse configResponse = ConfigResponse.fromJson(response);
      String packageName = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.getPackageName);
      if (configResponse.appsConfig.isNotEmpty) {
        for (var config in configResponse.appsConfig) {
          if (config.packageName == packageName) {
            return config.purchaseEnabled;
          }
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}