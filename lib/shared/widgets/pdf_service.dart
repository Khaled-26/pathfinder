import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PdfService {
  static Future<void> generateCareerReport({
    required String userName,
    required String userEmail,
    required String careerTrack,
    required Map<String, int> answers,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          // Header
          pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('800020'),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'PathFinder',
                  style: pw.TextStyle(
                    fontSize: 32,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  'Career Assessment Report',
                  style: const pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 24),

          // Student Info
          pw.Text(
            'Student Information',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('800020'),
            ),
          ),
          pw.Divider(color: PdfColor.fromHex('800020')),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.Text('Name: ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(userName),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            children: [
              pw.Text('Email: ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(userEmail),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            children: [
              pw.Text('Date: ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(DateTime.now().toString().split(' ')[0]),
            ],
          ),
          pw.SizedBox(height: 24),

          // Career Result
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('F5E6E8'),
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: PdfColor.fromHex('800020')),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Recommended Career Track',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('800020'),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  careerTrack,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('5C0016'),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 24),

          // Skills Breakdown
          pw.Text(
            'Skills Breakdown',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('800020'),
            ),
          ),
          pw.Divider(color: PdfColor.fromHex('800020')),
          pw.SizedBox(height: 8),
          ...answers.entries.map((e) {
            final percent = ((e.value / 3) * 100).toInt();
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      e.key.toUpperCase(),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('$percent%'),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.LinearProgressIndicator(
                  value: e.value / 3,
                  backgroundColor: PdfColors.grey300,
                  valueColor: PdfColor.fromHex('800020'),
                ),
                pw.SizedBox(height: 10),
              ],
            );
          }).toList(),
          pw.SizedBox(height: 24),

          // Footer
          pw.Divider(),
          pw.Center(
            child: pw.Text(
              'Generated by PathFinder - Ain Shams University',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey,
              ),
            ),
          ),
        ],
      ),
    );

    // Save and Share
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/career_report.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'My PathFinder Career Report',
    );
  }
}
