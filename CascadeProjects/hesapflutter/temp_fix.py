import sys
import re

path = r'c:\Users\botla\Desktop\CascadeProjects\hesapmakinasi2\CascadeProjects\hesapflutter\CascadeProjects\temp_verification_project\lib\main.dart'

try:
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Fix the top imports duplication. We just split at 'class AppTranslations {' and override top.
    idx = content.find('class AppTranslations {')
    if idx != -1:
        proper_imports = '''import 'dart:convert';
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
import 'package:share_plus/share_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'firebase_options.dart';

'''
        content = proper_imports + content[idx:]

    # 2. Fix the missing main() function and getTranslations
    pattern_trans = r"'tool_credits_summary': 'Kostenlose Werkzeug-Credits: \{0\} / \{1\}',\n    \},\n  \};\n*(.*?)\n  // Force Update Kontrolü"
    
    match = re.search(pattern_trans, content, flags=re.DOTALL)
    if match:
        original_main = '''
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
    debugPrint("Initialization failure (Firebase/Ads): $e");
    // Show a more prominent error in debug mode
    if (kDebugMode) {
      print("CRITICAL: Firebase initialization failed. Check your configuration.");
    }
  }
  
  // await Purchases.setLogLevel(LogLevel.debug); // Production'da debug log kapalı
  
  if (Platform.isAndroid) {
    PurchasesConfiguration configuration = PurchasesConfiguration("goog_pYMPiDyqDdQmvwVWiKWoQLjpPUs");
    await Purchases.configure(configuration);
  } else if (Platform.isIOS) {
    // Add iOS API key here when ready to deploy to App Store
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
        debugPrint("Firebase Auth Success: $uid");
        await Purchases.logIn(uid);
        await analytics.setUserId(id: uid);
        
        // Facebook'tan müşterinin kimliğini çekip RevenueCat'e bildir.
        String? fbAnonId = await FacebookAppEvents().getAnonymousId();
        if (fbAnonId != null) {
          debugPrint("Facebook Anon ID fetched: $fbAnonId");
          await Purchases.setFBAnonymousID(fbAnonId);
        }
      }
    } catch (e) {
      debugPrint("Firebase Auth or RevenueCat login failed: $e");
    }
'''
        content = content[:match.start(1)] + original_main + '\n' + content[match.end(1):]

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

    print('Fixed successfully!!')
except Exception as e:
    print('Failed:', e)
