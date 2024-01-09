import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EnvConfigs {
  static final String apiBaseUrl = dotenv.get("API_BASE_URL", fallback: "");

  static final String resourcesBaseUrl = dotenv.get("RESOURCES_BASE_URL", fallback: "");

  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    switch (packageName) {
      case "vn.com.cinemax":
        await dotenv.load(fileName: ".env.prod");
        break;
      case "vn.com.cinemax.dev":
        await dotenv.load(fileName: ".env.dev");
        break;
      default:
        await dotenv.load(fileName: ".env.dev");
        break;
    }
  }
}