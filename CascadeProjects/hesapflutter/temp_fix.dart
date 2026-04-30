import 'dart:io';

void main() {
  final file = File(r'c:\Users\botla\Desktop\CascadeProjects\hesapmakinasi2\CascadeProjects\hesapflutter\CascadeProjects\temp_verification_project\lib\main.dart');
  var content = file.readAsStringSync();

  // Replace buggy Top Imports
  content = content.replaceFirst(
    "import 'dart:convert';\r\nimport 'package:flutter/material.dart';", 
    "import 'package:facebook_app_events/facebook_app_events.dart';\r\nimport 'dart:convert';\r\nimport 'package:flutter/material.dart';"
  );
  
  // Actually, wait, replacing the bad body. The bad body is:
  final badBlock = '''    },\r
  };\r
\r
      if (uid != null) {\r
        debugPrint("Firebase Auth Success: \$uid");\r
        await Purchases.logIn(uid);\r
        await analytics.setUserId(id: uid);\r
      }\r
    } catch (e) {\r
      debugPrint("Firebase Auth or RevenueCat login failed: \$e");\r
    }''';

  final badBlock2 = '''    },
  };

      if (uid != null) {
        debugPrint("Firebase Auth Success: \$uid");
        await Purchases.logIn(uid);
        await analytics.setUserId(id: uid);
      }
    } catch (e) {
      debugPrint("Firebase Auth or RevenueCat login failed: \$e");
    }''';

  final goodBlock = '''    },
  };

  static Map<String, String> getTranslations(String lang) {
    final base = all['TR']!;
    final target = all[lang] ?? base;
    return Map<String, String>.from(base)..addAll(target);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await MobileAds.instance.initialize();
    debugPrint("Firebase and Ads initialized successfully.");
  } catch (e) {
    debugPrint("Initialization failure (Firebase/Ads): \$e");
    if (kDebugMode) {
      print("CRITICAL: Firebase initialization failed. Check your configuration.");
    }
  }
  
  if (Platform.isAndroid) {
    PurchasesConfiguration configuration = PurchasesConfiguration("goog_pYMPiDyqDdQmvwVWiKWoQLjpPUs");
    await Purchases.configure(configuration);
  } else if (Platform.isIOS) {
  }

  final prefs = await SharedPreferences.getInstance();
  final bool languageSelected = prefs.getBool('languageSelected') ?? false;
  final String currentLanguage = prefs.getString('language') ?? 'TR';

  final analytics = FirebaseAnalytics.instance;
  await analytics.logAppOpen();

  // Firebase Auth: Anonim Giriş ve RevenueCat Senkronizasyonu
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    final uid = userCredential.user?.uid;
    if (uid != null) {
      debugPrint("Firebase Auth Success: \$uid");
      await Purchases.logIn(uid);
      await analytics.setUserId(id: uid);
      
      String? fbAnonId = await FacebookAppEvents().getAnonymousId();
      if (fbAnonId != null) {
        debugPrint("Facebook Anon ID fetched: \$fbAnonId");
        await Purchases.setFBAnonymousID(fbAnonId);
      }
    }
  } catch (e) {
    debugPrint("Firebase Auth or RevenueCat login failed: \$e");
  }''';

  content = content.replaceAll(badBlock, goodBlock);
  content = content.replaceAll(badBlock2, goodBlock);

  // Clean duplicated imports if any
  final duplicatedString = '''import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:ui';
import 'services/ai_service.dart';
import 'dart:io';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/calculator_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:share_plus/share_plus.dart';''';
  
  // It shouldn't be duplicated because we cleaned it earlier with replace_file_content! 
  // Let's just save.
  file.writeAsStringSync(content);
}
