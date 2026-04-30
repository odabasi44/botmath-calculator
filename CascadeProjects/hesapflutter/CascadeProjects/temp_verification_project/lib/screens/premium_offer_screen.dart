import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/calculator_theme.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
class PremiumOfferScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final VoidCallback onContinue;
  final FirebaseRemoteConfig remoteConfig;

  const PremiumOfferScreen({
    super.key,
    required this.translations,
    required this.theme,
    required this.onContinue,
    required this.remoteConfig,
  });

  @override
  State<PremiumOfferScreen> createState() => _PremiumOfferScreenState();
}

class _PremiumOfferScreenState extends State<PremiumOfferScreen> {
  Package? _monthlyPackage;
  bool _isLoading = true;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FacebookAppEvents _facebookAppEvents = FacebookAppEvents();

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
    
    // Log screen view
    _analytics.logEvent(name: 'premium_offer_viewed');
    _facebookAppEvents.logEvent(name: 'premium_offer_viewed');
  }

  Future<void> _fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.monthly != null) {
        setState(() {
          _monthlyPackage = offerings.current!.monthly;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _purchase() async {
    if (_monthlyPackage == null) return;
    setState(() => _isLoading = true);
    
    // Log intent to start trial
    _analytics.logEvent(name: 'start_trial_clicked');
    _facebookAppEvents.logEvent(name: 'start_trial_clicked');

    try {
      final purchaseResult = await Purchases.purchasePackage(_monthlyPackage!);
      final customerInfo = purchaseResult.customerInfo;
      if (customerInfo.entitlements.active.containsKey('premium') || 
          customerInfo.entitlements.active.containsKey('Premium')) {
        widget.onContinue();
      }
    } catch (e) {
      debugPrint("Purchase failed: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _restorePurchases() async {
    setState(() => _isLoading = true);
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      if (customerInfo.entitlements.active.containsKey('premium') || 
          customerInfo.entitlements.active.containsKey('Premium')) {
        widget.onContinue();
      }
    } catch (e) {
      debugPrint("Restore failed: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = _monthlyPackage?.storeProduct.priceString ?? (widget.translations['power'] == 'Üs' ? "49.99 TL" : "\$4.99");
    final trialInfo = widget.translations['premium_offer_trial_info']?.replaceAll('{0}', price) ?? 
        "3 days free, then $price/month. Cancel anytime.";

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C1C1E), Color(0xFF0A2A6E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Header with Close Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white60, size: 28),
                        onPressed: widget.onContinue,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Icon(Icons.workspace_premium, color: Colors.amber, size: 80),
                        const SizedBox(height: 24),
                        Text(
                          widget.translations['premium_offer_title'] ?? '3 GÜN ÜCRETSİZ DENE',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.translations['premium_offer_subtitle'] ?? 'Tüm Özelliklerin Kilidini Aç',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Features List
                        _buildFeatureRow(Icons.block, widget.translations['ad_free'] ?? 'Reklamsız deneyim'),
                        _buildFeatureRow(Icons.psychology, widget.translations['ai_solver'] ?? 'AI Çözücü'),
                        _buildFeatureRow(Icons.palette, widget.translations['custom_themes'] ?? 'Özel temalar'),
                        _buildFeatureRow(Icons.history, widget.translations['unlimited_history'] ?? 'Sınırsız geçmiş'),
                        
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Area
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        trialInfo,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _purchase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.black)
                            : Text(
                                widget.translations['start_free_trial'] ?? 'ÜCRETSİZ DENEMEYİ BAŞLAT',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _restorePurchases,
                            child: Text(
                              widget.translations['restore_purchase'] ?? 'Satın Alma Geri Yükle',
                              style: const TextStyle(color: Colors.white60, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.translations['premium_offer_footer'] ?? 'Devam ederek Kullanım Koşulları ve Gizlilik Politikası\'nı kabul etmiş olursunuz.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLink("Terms", "https://botlab.com/terms"),
                          const Text(" | ", style: TextStyle(color: Colors.white24)),
                          _buildLink("Privacy", "https://botlab.com/privacy"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.amber, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLink(String text, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white54, fontSize: 10, decoration: TextDecoration.underline),
      ),
    );
  }
}
