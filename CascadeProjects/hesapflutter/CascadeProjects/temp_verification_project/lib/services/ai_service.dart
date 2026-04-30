import 'dart:io';
import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';

class AIService {
  /// Sends an image to Firebase Cloud Function (Proxy) to solve the math problem.
  /// This keeps the API Key secure on the server side.
  Future<String> solveImage(File imageFile, String appUserId, String appVersion, bool isFreeAttempt, String language) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'solveMathProblem',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 30)),
      );

      final response = await callable.call(<String, dynamic>{
        'image': base64Image,
        'appUserId': appUserId,
        'appVersion': appVersion,
        'isFreeAttempt': isFreeAttempt,
        'language': language,
      });

      if (response.data != null && response.data['solution'] != null) {
        return _cleanLatex(response.data['solution']);
      }
      
      throw Exception('Çözüm alınamadı.');
      
    } on FirebaseFunctionsException catch (e) {
      // Özel hata durumları (İnternet yoksa genellikle 'unavailable' döner)
      if (e.code == 'unavailable' || e.code == 'cancelled') {
        throw Exception('network_error');
      }
      throw Exception('AI Servis Hatası (${e.code}): ${e.message}');
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('host')) {
        throw Exception('network_error');
      }
      throw Exception('Bir hata oluştu: $e');
    }
  }

  /// Cleans LaTeX notation from AI output to produce readable plain text.
  String _cleanLatex(String text) {
    String result = text;

    // Remove display math delimiters $$ ... $$ and $ ... $
    result = result.replaceAll(RegExp(r'\$\$'), '');
    result = result.replaceAll(RegExp(r'\$'), '');

    // Convert \frac{a}{b} → (a)/(b)
    result = result.replaceAllMapped(
      RegExp(r'\\frac\{([^}]*)\}\{([^}]*)\}'),
      (m) => '(${m[1]})/(${m[2]})',
    );

    // Convert \dfrac, \tfrac same as \frac
    result = result.replaceAllMapped(
      RegExp(r'\\[dt]frac\{([^}]*)\}\{([^}]*)\}'),
      (m) => '(${m[1]})/(${m[2]})',
    );

    // Common operators
    result = result.replaceAll(r'\times', '×');
    result = result.replaceAll(r'\cdot', '·');
    result = result.replaceAll(r'\div', '÷');
    result = result.replaceAll(r'\pm', '±');
    result = result.replaceAll(r'\neq', '≠');
    result = result.replaceAll(r'\leq', '≤');
    result = result.replaceAll(r'\geq', '≥');
    result = result.replaceAll(r'\approx', '≈');
    result = result.replaceAll(r'\sqrt', '√');
    result = result.replaceAll(r'\pi', 'π');
    result = result.replaceAll(r'\alpha', 'α');
    result = result.replaceAll(r'\beta', 'β');
    result = result.replaceAll(r'\theta', 'θ');
    result = result.replaceAll(r'\infty', '∞');
    result = result.replaceAll(r'\sum', 'Σ');
    result = result.replaceAll(r'\int', '∫');
    result = result.replaceAll(r'\rightarrow', '→');
    result = result.replaceAll(r'\leftarrow', '←');

    // Superscript: x^{2} → x²  (single digit exponents)
    result = result.replaceAllMapped(
      RegExp(r'\^\{([^}]*)\}'),
      (m) => '^${m[1]}',
    );

    // Remove remaining curly braces used as LaTeX grouping
    result = result.replaceAll(RegExp(r'\\[a-zA-Z]+\{'), '');
    result = result.replaceAll('{', '').replaceAll('}', '');

    // Remove remaining backslash commands like \left \right \displaystyle
    result = result.replaceAll(RegExp(r'\\[a-zA-Z]+'), '');

    // Clean up extra whitespace
    result = result.replaceAll(RegExp(r' {2,}'), ' ').trim();

    return result;
  }
}
