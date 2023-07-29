import 'dart:io';
import 'package:aplikasi_kepegawaian/pages/pdf/view_pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

laporanKuitansi(
  BuildContext context,
  String noSppd,
  String perihal,
  int nominal,
  String terbilang,
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
      tanggal,
    );
  }

  final data = await FirebaseFirestore.instance
      .collection('sppd')
      .where("no_sppd", isEqualTo: noSppd)
      .get();

  final dataPegawai = await FirebaseFirestore.instance
      .collection('users')
      .doc(data.docs[0]['userId'])
      .get();

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

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
              'Kuitansi',
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
                  'Sudah Terima dari',
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
                  'Bendahara Pengeluaran Dinas Komunikasi dan Informatika Kabupaten Hulu Sungai Selatan',
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
                  'Banyaknya Uang',
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
                  convertToIdr(nominal, 2),
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
                  'Buat Keperluan',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  '',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  perihal,
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 50)]),
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Text(
                  'Terbilang',
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
                  terbilang,
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
          ]),
          pw.SizedBox(height: 8),
          pw.Row(children: [
            pw.Expanded(
              flex: 1,
              child: pw.SizedBox.shrink(),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Kandangan, ${formatDate(DateTime.now())}',
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, bottom: 25),
                      child: pw.Text('Yang Menerima'),
                    ),
                    pw.Table(columnWidths: {
                      0: const pw.FlexColumnWidth(1.6),
                      1: const pw.FlexColumnWidth(0.3),
                      2: const pw.FlexColumnWidth(4)
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
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 3),
                          child: pw.Text(
                            'Alamat',
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
                            'Wahyu',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ]),
                    ])
                  ]),
            ),
          ]),
          pw.SizedBox(height: 50),
          pw.Row(children: [
            pw.Expanded(
                flex: 1,
                child: pw.Column(children: [
                  pw.Text('Mengetahui',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.Text('Pengguna Anggaran',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.SizedBox(height: 72),
                  pw.Text(dataPegawai['nama'],
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('NIP. ${dataPegawai['nip']}',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 11)),
                ])),
            pw.Expanded(
                flex: 1,
                child: pw.Column(children: [
                  pw.Text('Lunas Dibayar',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.Text('Bendahara Pengeluaran',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.SizedBox(height: 72),
                  pw.Text('Nadia Purnama',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('NIP. 197107261997032005',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 11)),
                ])),
            pw.Expanded(
                flex: 1,
                child: pw.Column(children: [
                  pw.Text('Mengetahui / Menyetujui',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.Text('Kepala Dinas',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      )),
                  pw.SizedBox(height: 72),
                  pw.Text('Hj. Rahmawaty, ST, MT',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('NIP. 197107261997032005',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: 11)),
                ])),
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
            String namePdf = "Kuitansi-$no";
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
