import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/pegawai/report_pegawai_view_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/laporan_sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

reportPegawai(
  BuildContext context,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  // Get data from docs and convert map to List
  List users = querySnapshot.docs.map((doc) => doc.data()).toList();

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.SizedBox(
                  width: 40,
                  child: pw.Image(image),
                ),
                pw.SizedBox(width: 20),
                pw.Column(children: [
                  pw.Text(
                    'PEMERINTAH KABUPATEN HULU SUNGAI SELATAN',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'DINAS KOMUNIKASI DAN INFORMATIKA',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Jalan Aluh Idut No. 66 A Telp / Fax. (0517) 21230  KANDANGAN - 71212',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ])
              ]),
              pw.Stack(children: [
                pw.Divider(),
                pw.Container(
                  padding: pw.EdgeInsets.only(top: 2),
                  child: pw.Divider(),
                )
              ]),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Data Pegawai',
                  style: pw.TextStyle(fontSize: 18),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Text(
                      'Nama',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      'NIP',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      'Golongan',
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.Text(
                      'Jabatan',
                      textAlign: pw.TextAlign.center,
                    ),
                  ]),
                  for (var user in users)
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(3),
                          child: pw.Text(user['nama']),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(3),
                          child: pw.Text(user['nip']),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(3),
                          child: pw.Text(user['golongan']),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(3),
                          child: pw.Text(user['jabatan']),
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        ];
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());

  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPegawaiViewPage(path: path),
      ));
}
