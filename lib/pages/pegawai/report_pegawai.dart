import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future reportPegawai() async {
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
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'DINAS KOMUNIKASI DAN INFORMATIKA',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Jalan Aluh Idut No. 66 A Telp / Fax. (0517) 21230  KANDANGAN - 71212',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ])
              ]),
              pw.Stack(children: [
                pw.Divider(),
                pw.Container(
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Divider(),
                )
              ]),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                  'Data Pegawai',
                  style: pw.TextStyle(
                    fontSize: 18,
                  ),
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
                      style: pw.TextStyle(),
                    ),
                    pw.Text(
                      'NIP',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(),
                    ),
                    pw.Text(
                      'Golongan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(),
                    ),
                    pw.Text(
                      'Bidang',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(),
                    ),
                    pw.Text(
                      'Jabatan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(),
                    ),
                  ]),
                  for (var user in users)
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(3),
                          child: pw.Text(user['nama'],
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(3),
                          child: pw.Text(user['nip'],
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(3),
                          child: pw.Text(user['golongan'],
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(3),
                          child: pw.Text(user['bidang'],
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(3),
                          child: pw.Text(user['jabatan'],
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        ];
      }));

  // simpan
  Uint8List bytes = await pdf.save();

  // buat file kosong di direktori
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/mydocument.pdf');

  // timpa file kosong dengan file pdf
  await file.writeAsBytes(bytes);

  // open pdf
  // return await OpenFile.open(file.path.toString());
  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );

  // ignore: use_build_context_synchronously
  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ReportPegawaiViewPage(path: path),
  //     ));
}
