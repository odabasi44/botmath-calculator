import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFService {
  static Future<void> generateAndShare({
    required String solution,
    required File? imageFile,
    required String shareMessage,
    required String title,
  }) async {
    final pdf = pw.Document();

    pw.MemoryImage? memoryImage;
    if (imageFile != null && await imageFile.exists()) {
      memoryImage = pw.MemoryImage(imageFile.readAsBytesSync());
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              if (memoryImage != null) ...[
                pw.Text("Problem:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Image(memoryImage, height: 300),
                ),
                pw.SizedBox(height: 20),
              ],
              pw.Text("AI Solution:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text(solution),
              pw.Spacer(),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "Solved by BOTLAB AI Calculator\nDownload on Google Play: https://play.google.com/store/apps/details?id=com.botlab.calculator",
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/ai_solution_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: shareMessage);
  }
}
