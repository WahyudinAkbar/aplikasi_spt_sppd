import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

reportSpt(
  BuildContext context,
  String noSurat,
  String nama,
  String maksudTujuan,
  String tempatTujuan,
  String tanggal,
  String tanggalBuatSpt,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_spt.jpg')).buffer.asUint8List(),
  );

  final getUser = await FirebaseFirestore.instance
      .collection('users')
      .where("nama", isEqualTo: nama)
      .get();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.SizedBox(
              width: 60,
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
            child: pw.Text(
              'SURAT PERINTAH TUGAS',
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline),
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Center(
              child: pw.Text(
            "Nomor : $noSurat",
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          )),
          pw.SizedBox(height: 20),
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(
              "Berdasarkan",
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),
            pw.Text(
              "     :     ",
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),
            pw.Text(
              "1.	Dokumen Pelaksanaan Anggaran Dinas Komunikasi dan Informatika \n    Kabupaten Hulu Sungai Selatan Tahun Anggaran 2022 \n2.	Arahan Kepala Dinas Komunikasi dan Informatika Kabupaten Hulu \n    Sungai Selatan",
              style: const pw.TextStyle(
                fontSize: 12,
              ),
            ),
          ]),
          pw.SizedBox(height: 30),
          pw.Center(
            child: pw.Text(
              'Menugaskan',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            'Kepada : ',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),
          pw.Table(
              columnWidths: {
                0: pw.FlexColumnWidth(0.8),
                1: pw.FlexColumnWidth(3.5),
                2: pw.FlexColumnWidth(3),
                3: pw.FlexColumnWidth(3.5),
              },
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'No.',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'NAMA / NIP',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'PANGKAT / GOL',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'JABATAN',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(9),
                    child: pw.Text(
                      '1',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text(
                      nama,
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text(
                      getUser.docs[0]['golongan'],
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text(
                      getUser.docs[0]['jabatan'],
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ]),
              ]),
          pw.SizedBox(height: 15),
          pw.Table(columnWidths: {
            0: pw.FlexColumnWidth(1.5),
            1: pw.FlexColumnWidth(0.3),
            2: pw.FlexColumnWidth(4),
          }, children: [
            pw.TableRow(children: [
              pw.Text(
                'Untuk',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
              pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
              pw.Text(
                maksudTujuan,
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Tanggal',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  tanggal,
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Text(
                'Tempat Tujuan',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
              pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
              pw.Text(
                tempatTujuan,
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
            ]),
          ]),
          pw.SizedBox(height: 18),
          pw.Text(
              'Demikian Surat Perintah Tugas ini diberikan untuk dipergunakan sebagaimana mestinya.',
              style: pw.TextStyle(
                fontSize: 12,
              )),
          pw.SizedBox(height: 18),
          pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(children: [
                pw.Text('Dikeluarkan di Kandangan\n$tanggalBuatSpt',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 12,
                    )),
                pw.SizedBox(height: 18),
                pw.Text('Kepala Dinas',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: 12,
                    )),
                pw.SizedBox(height: 72),
                pw.Text('Hj. Rahmawaty, ST, MT',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('Pembina Utama Muda \nNIP. 197107261997032005',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 12)),
              ])),
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
        builder: (context) => ReportViewPage(path: path),
      ));
}
