import 'dart:io';
import 'package:aplikasi_kepegawaian/pages/pdf/view_pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart' as pw;

laporanPengeluaran(
  BuildContext context,
  String noSppd,
  List keterangan,
  List jumlah,
  int total,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  String formatDate(tanggal) {
    return DateFormat(
      'd MMMM yyyy',
      'id',
    ).format(
      tanggal.toDate(),
    );
  }

  final dataSppd = await FirebaseFirestore.instance
      .collection('sppd')
      .where("no_sppd", isEqualTo: noSppd)
      .get();

  final dataPegawai = await FirebaseFirestore.instance
      .collection('users')
      .doc(dataSppd.docs[0]['userId'])
      .get();

  print(dataPegawai);

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
              'Pengeluaran Riil',
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Table(columnWidths: {
            0: const pw.FlexColumnWidth(0.7),
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
                  dataPegawai['nama'],
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
                  'NIP',
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
                  dataPegawai['nip'],
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
                  'Jabatan',
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
                  dataPegawai['jabatan'],
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
          pw.Text(
            "Berdasarkan Surat Perintah Perjalanan Dinas (SPPD) Nomor : ${dataSppd.docs[0]['no_sppd']} Tanggal ${formatDate(dataSppd.docs[0]['tanggal_berangkat'])}. Berikut Rincian Pengeluaran Perjalanan Dinas : ",
          ),
          pw.SizedBox(height: 12),
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
                      'Keterangan',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Jumlah',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ]),
                for (var i = 0; i < keterangan.length; i++)
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(9),
                      child: pw.Text(
                        '${i + 1}',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        keterangan[i],
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                        "Rp. ${jumlah[i].toString()}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      '',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Total',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Rp. $total',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ),
                ]),
              ]),
          pw.SizedBox(height: 12),
          pw.Text(
            'Demikian pernyataan ini kami buat dengan sebenarnya, untuk dipergunakan sebagaimana mestinya.',
          ),
          pw.SizedBox(height: 18),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(children: [
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
                ]),
                pw.Column(children: [
                  pw.Text('Pelaksana Perjalanan Dinas',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      )),
                  pw.SizedBox(height: 72),
                  pw.Text(dataPegawai['nama'],
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                      "${dataPegawai['jabatan']} \nNIP. ${dataPegawai['nip']}",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 12)),
                ])
              ]),
        ]);
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String temp = '$dir/report.pdf';
  final File file = File(temp);
  await file.writeAsBytes(await pdf.save());

  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfView(
          path: temp,
          callback: () async {
            String no = noSppd.substring(4, 7);
            String namePdf = "Pengeluaran-$no";
            var dir = await getExternalStorageDirectory();
            dir = Directory('/storage/emulated/0/Download');
            final File file =
                File(path.join(dir.path, path.basename('$namePdf.pdf')));
            await file.writeAsBytes(await pdf.save());

            Fluttertoast.showToast(
                msg: "PDF Berhasil Disimpan",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          },
        ),
      ));
}
