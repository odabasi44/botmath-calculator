import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/calculator_theme.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:io';

import 'package:flutter/services.dart';

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
  List<Package> _availablePackages = [];
  Package? _selectedPackage;
  bool _isLoading = true;
  bool _isPurchasing = false;
  String? _errorMessage;
  
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FacebookAppEvents _facebookAppEvents = FacebookAppEvents();

  // URLs as per Apple Compliance
  static const String privacyUrl = "https://www.lisansarsivi.com/gizlilik-politikalarimiz/";
  static const String termsUrl = "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/";

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
    
    _analytics.logEvent(name: 'premium_offer_viewed');
    _facebookAppEvents.logEvent(name: 'premium_offer_viewed');
  }

  Future<void> _fetchOfferings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String diagnosticLog = "";
    
    try {
      diagnosticLog += "1. Checking SDK Configuration...\n";
      bool isConfigured = await Purchases.isConfigured;
      if (!isConfigured) {
        throw "SDK is NOT configured. Check your API Key.";
      }
      
      diagnosticLog += "2. Fetching Customer Info...\n";
      try {
        await Purchases.getCustomerInfo();
      } catch (e) {
        diagnosticLog += "(!) Customer Info fetch failed (Internet issue?)\n";
      }

      diagnosticLog += "3. Fetching Offerings...\n";
      Offerings offerings = await Purchases.getOfferings();
      
      if (offerings.current == null) {
        if (offerings.all.isNotEmpty) {
          throw "Offerings found, but NO 'Current' offering is set in RevenueCat Dashboard. Set one as 'Current'.";
        } else {
          throw "No Offerings found at all. Check Products and Offerings in RevenueCat.";
        }
      }

      if (offerings.current!.availablePackages.isEmpty) {
        throw "Offering '${offerings.current!.identifier}' has NO packages attached. Add products to this offering.";
      }

      setState(() {
        _availablePackages = offerings.current!.availablePackages;
        // Default to monthly if available, else first one
        _selectedPackage = _availablePackages.firstWhere(
          (p) => p.packageType == PackageType.monthly,
          orElse: () => _availablePackages.first,
        );
        _isLoading = false;
      });
    } catch (e) {
      String techError = e.toString();
      String suggestion = "Please check your internet and try again.";
      
      if (techError.contains("11")) {
        suggestion = "Apple Credentials Error. RevenueCat cannot reach Apple. Check your p8 keys and Issuer ID.";
      } else if (techError.contains("Current")) {
        suggestion = "Go to RevenueCat -> Offerings and mark one as 'Current'.";
      } else if (techError.contains("No Offerings")) {
        suggestion = "Ensure your products are 'Ready to Submit' and attached to an Offering.";
      }

      setState(() {
        _isLoading = false;
        _errorMessage = "[V46 DIAGNOSTICS]\n\n"
            "Status Log:\n$diagnosticLog\n"
            "Critical Error: $techError\n\n"
            "Solution: $suggestion";
      });
    }
  }

  Future<void> _purchase() async {
    if (_selectedPackage == null) {
      _showSnackBar("Please select a package first.");
      return;
    }

    setState(() => _isPurchasing = true);
    _analytics.logEvent(name: 'purchase_attempt', parameters: {'package': _selectedPackage!.identifier});

    try {
      final purchaseResult = await Purchases.purchasePackage(_selectedPackage!);
      final customerInfo = purchaseResult.customerInfo;
      
      if (customerInfo.entitlements.active.containsKey('premium') || 
          customerInfo.entitlements.active.containsKey('Premium')) {
        _analytics.logEvent(name: 'purchase_success');
        if (mounted) widget.onContinue();
      }
    } catch (e) {
      bool userCancelled = false;
      if (e is PlatformException) {
        // Check if the error code corresponds to a user cancellation
        // In purchases_flutter, this is often handled via a dedicated check
      }
      
      // Standard way to check for cancellation in RevenueCat Flutter
      debugPrint("Purchase error details: $e");
      
      // If it's not a cancellation, show error
      if (e.toString().contains("PurchasesErrorCode.purchaseCancelledError")) {
         // User cancelled, do nothing
      } else {
        _showErrorDialog("An error occurred during purchase. Please try again.");
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  Future<void> _restorePurchases() async {
    setState(() => _isPurchasing = true);
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      if (customerInfo.entitlements.active.containsKey('premium') || 
          customerInfo.entitlements.active.containsKey('Premium')) {
        _showSnackBar("Purchases restored successfully!");
        if (mounted) widget.onContinue();
      } else {
        _showSnackBar("No active subscription found to restore.");
      }
    } catch (e) {
      _showErrorDialog("Restore failed. Please check your account.");
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Notice"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                _buildHeader(),
                Expanded(
                  child: _isLoading 
                    ? const Center(child: CircularProgressIndicator(color: Colors.amber))
                    : _errorMessage != null
                      ? _buildErrorUI()
                      : _buildContent(),
                ),
                if (!_isLoading && _errorMessage == null) _buildFooter(),
              ],
            ),
          ),

          // Purchasing Overlay
          if (_isPurchasing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.amber),
                    SizedBox(height: 16),
                    Text("Processing...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white60, size: 28),
            onPressed: _isPurchasing ? null : widget.onContinue,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchOfferings,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Icon(Icons.workspace_premium, color: Colors.amber, size: 70),
          const SizedBox(height: 16),
          Text(
            widget.translations['premium_offer_title'] ?? 'TRY 3 DAYS FOR FREE',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.translations['premium_offer_subtitle'] ?? 'Unlock All Features',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 30),
          
          _buildFeatureRow(Icons.block, widget.translations['ad_free'] ?? 'Ad-free experience'),
          _buildFeatureRow(Icons.psychology, widget.translations['ai_solver'] ?? 'AI Solver (Premium)'),
          _buildFeatureRow(Icons.palette, widget.translations['custom_themes'] ?? 'Custom themes'),
          _buildFeatureRow(Icons.history, widget.translations['unlimited_history'] ?? 'Unlimited history'),
          
          const SizedBox(height: 30),
          
          // Package Selection List
          ..._availablePackages.map((package) => _buildPackageTile(package)),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPackageTile(Package package) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    String durationLabel = "";
    switch (package.packageType) {
      case PackageType.weekly: durationLabel = "Weekly"; break;
      case PackageType.monthly: durationLabel = "Monthly"; break;
      case PackageType.annual: durationLabel = "Yearly"; break;
      default: durationLabel = "Premium";
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedPackage = package),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.withOpacity(0.15) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    durationLabel,
                    style: TextStyle(
                      color: isSelected ? Colors.amber : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  if (package.packageType == PackageType.annual)
                    const Text("Best Value", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                ],
              ),
            ),
            Text(
              package.storeProduct.priceString,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: (_isPurchasing || _selectedPackage == null) ? null : _purchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
              child: Text(
                widget.translations['start_free_trial'] ?? 'START FREE TRIAL',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _isPurchasing ? null : _restorePurchases,
            child: Text(
              widget.translations['restore_purchase'] ?? 'Restore Purchase',
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.translations['premium_offer_footer'] ?? 'By continuing, you agree to our Terms and Privacy Policy.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLink("Terms of Use", termsUrl),
              const Text(" | ", style: TextStyle(color: Colors.white24)),
              _buildLink("Privacy Policy", privacyUrl),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLink(String text, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white54, fontSize: 11, decoration: TextDecoration.underline),
      ),
    );
  }
}
