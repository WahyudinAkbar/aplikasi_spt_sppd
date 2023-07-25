import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

laporanKegiatan(
  String noSppd,
  List kegiatan,
  List tanggal,
  List keterangan,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  List formatTanggal = [];

  String formatDate(tanggal) {
    return DateFormat(
      'd MMMM yyyy',
      'id',
    ).format(
      tanggal.toDate(),
    );
  }

  for (var i = 0; i < tanggal.length; i++) {
    formatTanggal.add(formatDate(tanggal[i]));
  }

  final data = await FirebaseFirestore.instance
      .collection('sppd')
      .where("no_sppd", isEqualTo: noSppd)
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
          pw.Stack(children: [
            pw.Divider(),
            pw.Container(
              padding: const pw.EdgeInsets.only(top: 2),
              child: pw.Divider(),
            )
          ]),
          pw.SizedBox(height: 8),
          pw.Center(
            child: pw.Text(
              'Kegiatan Perjalanan Dinas',
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Table(columnWidths: {
            0: const pw.FlexColumnWidth(1.4),
            1: const pw.FlexColumnWidth(0.3),
            2: const pw.FlexColumnWidth(4),
          }, children: [
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Nama',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  data.docs[0]['nama'],
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Nomor SPPD',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  data.docs[0]['no_sppd'],
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Tempat Tujuan',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  data.docs[0]['tempat_tujuan'],
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Tanggal Berangkat',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  formatDate(data.docs[0]['tanggal_berangkat']),
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Tanggal Kembali',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  ':',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  formatDate(data.docs[0]['tanggal_kembali']),
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
          ]),
          pw.SizedBox(height: 6),
          pw.Stack(children: [
            pw.Divider(),
            pw.Container(
              padding: const pw.EdgeInsets.only(top: 2),
              child: pw.Divider(),
            )
          ]),
          pw.SizedBox(height: 4),
          pw.Text('Kegiatan : ',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(0.8),
                1: const pw.FlexColumnWidth(3.5),
                2: const pw.FlexColumnWidth(3),
                3: const pw.FlexColumnWidth(3.5),
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
                      'Kegiatan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Tanggal',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Keterangan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ]),
                for (var i = 0; i < 3; i++)
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(9),
                      child: pw.Text(
                        '1',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        kegiatan[i],
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        // getUser.docs[0]['golongan'],
                        formatTanggal[i].toString(),
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        // getUser.docs[0]['jabatan'],
                        keterangan[i],
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ]),
              ]),
          pw.SizedBox(height: 18),
          pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(children: [
                pw.Text('Kepala Dinas',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 12,
                    )),
                pw.SizedBox(height: 72),
                pw.Text('Hj. Rahmawaty, ST, MT',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('Pembina Utama Muda \nNIP. 197107261997032005',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 12)),
              ])),
        ]);
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());

  // ignore: use_build_context_synchronously
  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
