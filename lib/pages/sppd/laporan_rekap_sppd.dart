import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

laporanRekapSppd() async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('sppd').get();

  List sppd = querySnapshot.docs.map((doc) => doc.data()).toList();

  String formatDate(date) {
    return DateFormat(
      'd MMMM yyyy',
      'id',
    ).format(date.toDate());
  }

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (pw.Context context) {
        return [
          pw.Align(
            alignment: pw.Alignment.topCenter,
            child: pw.Column(
              children: [
                pw.Row(children: [
                  pw.SizedBox(width: 130),
                  pw.SizedBox(
                    width: 40,
                    child: pw.Image(image),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    children: [
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
                    ],
                  )
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
                    'Rekap Surat Perintah Perjalanan Dinas',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      pw.Text(
                        'No',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'No Surat',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Nama',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Tanggal Berangkat',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Tanggal Kembali',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Maksud Tujuan',
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.Text(
                        'Tempat Tujuan',
                        textAlign: pw.TextAlign.center,
                      ),
                    ]),
                    for (var i = 0; i < sppd.length; i++)
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child: pw.Text('${i + 1}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child: pw.Text(sppd[i]['no_sppd']),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child: pw.Text(sppd[i]['nama']),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child: pw.Text(
                                formatDate(sppd[i]['tanggal_berangkat'])),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child:
                                pw.Text(formatDate(sppd[i]['tanggal_kembali'])),
                          ),
                          pw.Padding(
                              padding: const pw.EdgeInsets.all(3),
                              child: pw.Container(
                                width: 200,
                                child: pw.Text(sppd[i]['maksud_tujuan'],
                                    maxLines: 2,
                                    overflow: pw.TextOverflow.visible),
                              )),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(3),
                            child: pw.Text(sppd[i]['tempat_tujuan']),
                          ),
                        ],
                      ),
                  ],
                )
              ],
            ),
          )
        ];
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
