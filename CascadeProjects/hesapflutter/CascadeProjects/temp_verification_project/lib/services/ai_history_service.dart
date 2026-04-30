import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class AIHistoryEntry {
  final String id;
  final String imagePath;
  final String solution;
  final DateTime timestamp;

  AIHistoryEntry({
    required this.id,
    required this.imagePath,
    required this.solution,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'solution': solution,
        'timestamp': timestamp.toIso8601String(),
      };

  factory AIHistoryEntry.fromJson(Map<String, dynamic> json) => AIHistoryEntry(
        id: json['id'],
        imagePath: json['imagePath'],
        solution: json['solution'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

class AIHistoryService {
  static const String _storageKey = 'ai_history_list';
  static const int _maxPremiumEntries = 10;
  static const int _maxFreeEntries = 1;

  static Future<void> saveEntry(File imageFile, String solution) async {
    final prefs = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();
    final String aiDir = p.join(directory.path, 'ai_history');
    await Directory(aiDir).create(recursive: true);

    final String fileName = 'ai_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String permanentPath = p.join(aiDir, fileName);

    // Copy image to permanent storage
    await imageFile.copy(permanentPath);

    final List<AIHistoryEntry> history = await loadHistory();
    final newEntry = AIHistoryEntry(
      id: fileName,
      imagePath: permanentPath,
      solution: solution,
      timestamp: DateTime.now(),
    );

    history.insert(0, newEntry);

    // Trim history to 10 entries (as requested by user for the system max)
    if (history.length > 10) {
      final removed = history.sublist(10);
      for (var entry in removed) {
        final file = File(entry.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      }
      history.removeRange(10, history.length);
    }

    final List<String> jsonList = history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_storageKey, jsonList);
  }

  static Future<List<AIHistoryEntry>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_storageKey);
    if (jsonList == null) return [];

    return jsonList.map((e) => AIHistoryEntry.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadHistory();
    for (var entry in history) {
      final file = File(entry.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await prefs.remove(_storageKey);
  }
}
