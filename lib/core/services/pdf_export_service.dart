import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/watermark_config.dart';

class PdfExportService {
  /// Generates a formal single-page PDF document embedding the watermarked ID image
  static Future<Uint8List> generatePdfDocument({
    required Uint8List imageBytes,
    required WatermarkConfig config,
    required String sha256Checksum,
  }) async {
    final pdf = pw.Document(
      title: 'Dokumen Identitas Ter-Watermark - ${config.purpose}',
      author: 'IDMark (idmark.faishal.id)',
      subject: config.purpose,
    );

    final image = pw.MemoryImage(imageBytes);
    final now = DateTime.now();
    final formattedDate = '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 12),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey400, width: 1.5)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'IDMARK — DOKUMEN IDENTITAS TER-WATERMARK',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blueGrey900,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Sesuai Prinsip Pelindungan Data Pribadi (UU No. 27/2022)',
                          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.blue50,
                        borderRadius: pw.BorderRadius.circular(4),
                        border: pw.Border.all(color: PdfColors.blue300),
                      ),
                      child: pw.Text(
                        '100% On-Device',
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Purpose & Validation Meta Card
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: PdfColors.grey300),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'Tujuan Penggunaan: ',
                          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            config.purpose,
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.red900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 6),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Tanggal Transaksi: ${config.transactionDate.day.toString().padLeft(2, '0')}-${config.transactionDate.month.toString().padLeft(2, '0')}-${config.transactionDate.year}',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey800),
                        ),
                        pw.Text(
                          'Waktu Cetak: $formattedDate WIB',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Embedded ID Image Canvas
              pw.Expanded(
                child: pw.Center(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey400, width: 1),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Image(image, fit: pw.BoxFit.contain),
                  ),
                ),
              ),
              pw.SizedBox(height: 16),

              // Integrity Checksum & Legal Notice Footer
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  border: pw.Border.all(color: PdfColors.grey300),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'SHA-256 Checksum: ',
                          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            sha256Checksum,
                            style: const pw.TextStyle(
                              fontSize: 8,
                              fontStyle: pw.FontStyle.italic,
                              color: PdfColors.blueGrey800,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'PEMBERITAHUAN HUKUM: Salinan dokumen identitas ini hanya sah dan diizinkan untuk tujuan yang tertera di atas. Penggunaan di luar peruntukan tersebut merupakan tindak pidana penyalahgunaan data pribadi.',
                      style: const pw.TextStyle(fontSize: 7.5, color: PdfColors.grey700, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
