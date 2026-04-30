$path = "c:\Users\botla\Desktop\CascadeProjects\hesapmakinasi2\CascadeProjects\hesapflutter\CascadeProjects\temp_verification_project\lib\main.dart"
$content = [System.IO.File]::ReadAllText($path)

$bad = '    },
  };

      if (uid != null) {
        debugPrint("Firebase Auth Success: $uid");
        await Purchases.logIn(uid);
        await analytics.setUserId(id: uid);
      }
    } catch (e) {
      debugPrint("Firebase Auth or RevenueCat login failed: $e");
    }'

$bad2 = "    },`r`n  };`r`n`r`n      if (uid != null) {`r`n        debugPrint(`"Firebase Auth Success: `$uid`");`r`n        await Purchases.logIn(uid);`r`n        await analytics.setUserId(id: uid);`r`n      }`r`n    } catch (e) {`r`n      debugPrint(`"Firebase Auth or RevenueCat login failed: `$e`");`r`n    }"

$good = '    },
  };

  static Map<String, String> getTranslations(String lang) {
    final base = all[''TR'']!;
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
  final bool languageSelected = prefs.getBool(''languageSelected'') ?? false;
  final String currentLanguage = prefs.getString(''language'') ?? ''TR'';

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
      
      String? fbAnonId = await FacebookAppEvents().getAnonymousId();
      if (fbAnonId != null) {
        debugPrint("Facebook Anon ID fetched: $fbAnonId");
        await Purchases.setFBAnonymousID(fbAnonId);
      }
    }
  } catch (e) {
    debugPrint("Firebase Auth or RevenueCat login failed: $e");
  }'

if ($content.Contains($bad)) {
    $content = $content.Replace($bad, $good)
} elseif ($content.Contains($bad2)) {
    $content = $content.Replace($bad2, $good)
}

[System.IO.File]::WriteAllText($path, $content)
