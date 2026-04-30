import 'dart:io';
import 'package:flutter/material.dart';
import '../services/ai_history_service.dart';
import '../services/pdf_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:ui';
class AIHistoryScreen extends StatefulWidget {
  final Map<String, String> translations;
  final bool isPremium;

  const AIHistoryScreen({
    super.key,
    required this.translations,
    required this.isPremium,
  });

  @override
  State<AIHistoryScreen> createState() => _AIHistoryScreenState();
}

class _AIHistoryScreenState extends State<AIHistoryScreen> {
  List<AIHistoryEntry> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final history = await AIHistoryService.loadHistory();
    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  Future<void> _showPurchaseDialog() async {
    try {
      final facebookAppEvents = FacebookAppEvents();
      await facebookAppEvents.logEvent(name: 'history_lock_view_premium');
      
      await RevenueCatUI.presentPaywallIfNeeded('Premium');
      
      final customerInfo = await Purchases.getCustomerInfo();
      final isPremium = customerInfo.entitlements.active.containsKey('premium') || 
                        customerInfo.entitlements.active.containsKey('Premium');
      
      if (mounted && isPremium) {
        // Refresh data if they bought premium
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paywall error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Limits: Free = 1, Premium = 10
    final int displayLimit = widget.isPremium ? 10 : 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: Text(
          widget.translations['ai_history'] ?? 'AI History',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? Center(
                  child: Text(
                    widget.translations['no_ai_history'] ?? 'No history yet',
                    style: const TextStyle(color: Colors.white60),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final entry = _history[index];
                    final isLocked = index >= displayLimit;

                    return _buildHistoryItem(entry, isLocked);
                  },
                ),
    );
  }

  Widget _buildHistoryItem(AIHistoryEntry entry, bool isLocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(entry.imagePath),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(entry.timestamp),
                            style: const TextStyle(color: Colors.white38, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.solution,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (!isLocked) ...[
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => _shareEntry(entry),
                        icon: const Icon(Icons.share, size: 18),
                        label: Text(widget.translations['share'] ?? 'Share'),
                        style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      ),
                      TextButton.icon(
                        onPressed: () => _viewDetail(entry),
                        icon: const Icon(Icons.visibility, size: 18),
                        label: Text(widget.translations['view_btn'] ?? 'View'),
                        style: TextButton.styleFrom(foregroundColor: Colors.green),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (isLocked)
            Positioned.fill(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.lock, color: Colors.amber, size: 28),
                              const SizedBox(height: 4),
                              Text(
                                widget.translations['premium_history_desc'] ?? 'Buy Premium for more!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _showPurchaseDialog,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  widget.translations['view_premium_packages'] ?? 'Premium Paketleri İncele',
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }

  void _shareEntry(AIHistoryEntry entry) {
    PDFService.generateAndShare(
      solution: entry.solution,
      imageFile: File(entry.imagePath),
      shareMessage: widget.translations['share_ai_message'] ?? 'Check out this solution!',
      title: widget.translations['ai_solver'] ?? 'AI Solver',
    );
  }

  void _viewDetail(AIHistoryEntry entry) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1E),
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Image.file(File(entry.imagePath)),
                  const SizedBox(height: 20),
                  Text(
                    entry.solution,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
