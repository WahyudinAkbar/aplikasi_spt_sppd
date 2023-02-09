import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/sppd/report_sppd_view_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

reportSppd(
  BuildContext context,
  // String noSurat,
  // String nama,
  // String maksudTujuan,
  // String tempatTujuan,
  // String tanggal,
  // String tanggalBuatSpt,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  // final getUser = await FirebaseFirestore.instance
  //     .collection('users')
  //     .where("nama", isEqualTo: )
  //     .get();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.SizedBox(
              width: 40,
              child: pw.Image(image),
            ),
            pw.SizedBox(width: 20),
            pw.Column(children: [
              pw.Text(
                'PEMERINTAH KABUPATEN HULU SUNGAI SELATAN',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'DINAS KOMUNIKASI DAN INFORMATIKA',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Jalan Aluh Idut No. 66 A Telp / Fax. (0517) 21230  KANDANGAN - 71212',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            ])
          ]),
          pw.Divider(),
          pw.SizedBox(height: 20),
          pw.Center(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Lembar Ke',
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        pw.Text(
                          'Kode Nomor',
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        pw.Text(
                          'Nomor',
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ]),
                  pw.Column(children: [
                    pw.Text(
                      '    :    ',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '    :    ',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '    :    ',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ]),
                  pw.Column(children: [
                    pw.Text(
                      '    :',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '    :',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '090 /       - DD / DisKominfo',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ]),
                ]),
          ),
          pw.SizedBox(height: 2),
          pw.Center(
            child: pw.Text(
              'SURAT PERINTAH PERJALANAN DINAS',
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Table(
              columnWidths: {
                0: pw.FlexColumnWidth(2.5),
                1: pw.FlexColumnWidth(3.5),
              },
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      '1. 	Pejabat yang memberi perintah',
                      style: pw.TextStyle(fontSize: 8),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'KEPALA DINAS KOMUNIKASI DAN INFORMATIKA KAB.HSS',
                      style: pw.TextStyle(fontSize: 8),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      '2.  Nama pegawai yang diperintah',
                      style: pw.TextStyle(fontSize: 8),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'KEPALA DINAS KOMUNIKASI DAN INFORMATIKA KAB.HSS',
                      style: pw.TextStyle(fontSize: 8),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Table(children: [
                      pw.TableRow(children: [
                        pw.Text(
                          '3.  ',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'a.  ',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Pangkat dan golongan ruang gaji \nmenurut PP. No. 6 Tahun 1997',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          '',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'b.  ',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Jabatan',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [pw.Text('\n')]),
                      pw.TableRow(children: [
                        pw.Text(
                          '',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'c.  ',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Tingkat menurut peraturan perjalanan',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [pw.Text('\n')]),
                    ]),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Table(children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'a.',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Pangkat dan golongan ruang gaji',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [pw.Text('\n')]),
                      pw.TableRow(children: [
                        pw.Text(
                          'b.',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Jabatan',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [pw.Text('\n')]),
                      pw.TableRow(children: [
                        pw.Text(
                          'c.',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Tingkat menurut peraturan perjalanan',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [pw.Text('\n')]),
                    ]),
                  ),
                ]),
              ]),
        ]);
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());

  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportSppdViewPage(path: path),
      ));
}
