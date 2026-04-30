import 'dart:io';

void main() {
  final path = r'c:\Users\botla\Desktop\CascadeProjects\hesapmakinasi2\CascadeProjects\hesapflutter\CascadeProjects\temp_verification_project\lib\main.dart';
  final file = File(path);
  var lines = file.readAsLinesSync();

  // Find the boundary
  int startIndex = -1;
  int endIndex = -1;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains("if (uid != null) {")) {
      if (lines[i+1].contains("debugPrint(\"Firebase Auth Success:")) {
        startIndex = i;
      }
    }
    if (startIndex != -1 && lines[i].contains("debugPrint(\"Firebase Auth or RevenueCat login failed:")) {
      endIndex = i + 1; // including the catch bracket line
      break;
    }
  }

  if (startIndex != -1 && endIndex != -1) {
    print("Found bounds: $startIndex to $endIndex");
    
    final goodBlock = '''
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

    lines.replaceRange(startIndex, endIndex + 1, goodBlock.split('\n'));
    file.writeAsStringSync(lines.join('\n'));
    print("Replaced successfully.");
  } else {
    print("Bounds not found.");
  }
}
