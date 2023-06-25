import 'dart:io';

import 'package:aplikasi_kepegawaian/pages/spt/report_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

laporanSppd(
  String noSurat,
  String nama,
  String maksudTujuan,
  String tempatTujuan,
  String tanggalBerangkat,
  String tanggalKembali,
  String hari,
  String alatTransportasi,
  String keterangan,
  String sendTime,
) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/logo_report_sppd.png')).buffer.asUint8List(),
  );

  final getUser = await FirebaseFirestore.instance
      .collection('users')
      .where("nama", isEqualTo: nama)
      .get();

  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
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
                padding: const pw.EdgeInsets.only(top: 2),
                child: pw.Divider(),
              )
            ]),
            pw.SizedBox(height: 10),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 180),
              child: pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(0.4),
                  1: pw.FlexColumnWidth(0.04),
                  2: pw.FlexColumnWidth(1.7),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Text(
                      'Lembar Ke',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Text(
                      'Kode No',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      '',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Text(
                      'Nomor',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    pw.Text(
                      noSurat,
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ])
                ],
              ),
              // pw.Row(
              //     mainAxisAlignment: pw.MainAxisAlignment.center,
              //     children: [
              //       pw.Column(
              //           crossAxisAlignment: pw.CrossAxisAlignment.start,
              //           children: [
              //             pw.Text(
              //               'Lembar Ke',
              //               style: const pw.TextStyle(
              //                 fontSize: 8,
              //               ),
              //             ),
              //             pw.Text(
              //               'Kode Nomor',
              //               style: const pw.TextStyle(
              //                 fontSize: 8,
              //               ),
              //             ),
              //             pw.Text(
              //               'Nomor',
              //               style: const pw.TextStyle(
              //                 fontSize: 8,
              //               ),
              //             ),
              //           ]),
              //       pw.Column(children: [
              //         pw.Text(
              //           '    :    ',
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //         pw.Text(
              //           '    :    ',
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //         pw.Text(
              //           '    :    ',
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //       ]),
              //       pw.Column(children: [
              //         pw.Text(
              //           '',
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //         pw.Text(
              //           '',
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //         pw.Text(
              //           noSurat,
              //           style: const pw.TextStyle(
              //             fontSize: 8,
              //           ),
              //         ),
              //       ]),
              //     ]),
            ),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                'SURAT PERINTAH PERJALANAN DINAS',
                style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline),
              ),
            ),
            pw.SizedBox(height: 8),
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
                        '1. 	 Pejabat yang memberi perintah',
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
                        '2.   Nama pegawai yang diperintah',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        nama,
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
                            getUser.docs[0]['golongan'],
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            getUser.docs[0]['jabatan'],
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            '',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                      ]),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '4.   Maksud Perjalanan Dinas',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        maksudTujuan,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '5.   Alat Angkut yang dipergunakan',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        alatTransportasi,
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
                            '6.',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'a.',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Tempat Berangkat',
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
                            'b.',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Tempat Tujuan',
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
                            'Kandangan',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            tempatTujuan,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                      ]),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Table(children: [
                        pw.TableRow(children: [
                          pw.Text(
                            '7. ',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'a.  ',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Lamanya Perjalanan Dinas',
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
                            'b.  ',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Tanggal Berangkat',
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
                            'Tanggal Harus Kembali',
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
                            '$hari Hari',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            tanggalBerangkat,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            tanggalKembali,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                      ]),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '8.   Pengikut',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '',
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
                            '9.',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Pembebanan Anggaran',
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
                            'a.  Instansi',
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
                            'b.  Mata Anggaran',
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
                          pw.Text('\n'),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            'Dinas Komunikasi dan Informatika Kabupaten Hulu Sungai Selatan',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                        pw.TableRow(children: [
                          pw.Text(
                            'Anggaran',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ]),
                        pw.TableRow(children: [pw.Text('\n')]),
                      ]),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '10.  Keterangan Lain-lain',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                        '$keterangan',
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                  ]),
                ]),
            pw.SizedBox(height: 20),
            pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                    margin: const pw.EdgeInsets.only(right: 80),
                    child: pw.Column(
                      children: [
                        pw.Text('Dikeluarkan di Kandangan\n $sendTime',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 8,
                            )),
                        pw.SizedBox(height: 18),
                        pw.Text('Kepala Dinas',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 8,
                            )),
                        pw.SizedBox(height: 60),
                        pw.Text('Hj. Rahmawaty, ST, MT',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Pembina Utama Muda \nNIP. 197107261997032005',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 8)),
                      ],
                    ))),
          ]),
          pw.Column(
            children: [
              pw.Align(
                alignment: pw.Alignment.topRight,
                child: pw.Container(
                  width: 200,
                  child: pw.Table(
                    columnWidths: {
                      0: pw.FlexColumnWidth(1.4),
                      1: pw.FlexColumnWidth(0.2),
                      2: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'SPPD No.',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          noSurat,
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Berangkat Dari \n(Tempat kedudukan)',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          'Kandangan',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          tanggalBerangkat,
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Ke',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          tempatTujuan,
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Selaku Pelaksana Teknis Kegiatan',
                style:
                    pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Table(border: pw.TableBorder.all(), children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Tiba Di',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ])
                    ]),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Berangkat Dari',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Ke',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                    ]),
                  )
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Tiba Di',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ])
                    ]),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Berangkat Dari',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Ke',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                    ]),
                  )
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Tiba Di',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ]),
                      pw.TableRow(children: [
                        pw.Text('\n'),
                      ])
                    ]),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(3),
                    child: pw.Table(columnWidths: {
                      0: pw.FlexColumnWidth(1),
                      1: pw.FlexColumnWidth(2),
                    }, children: [
                      pw.TableRow(children: [
                        pw.Text(
                          'Berangkat Dari',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Ke',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Pada Tanggal',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Text(
                          'Kepala',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                        pw.Text(
                          ':',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ]),
                    ]),
                  )
                ]),
              ]),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(85, 3, 3, 3),
                        child: pw.Column(
                          children: [
                            pw.Table(columnWidths: {
                              0: pw.FlexColumnWidth(0.3),
                              1: pw.FlexColumnWidth(0.04),
                              2: pw.FlexColumnWidth(1.9),
                            }, children: [
                              pw.TableRow(children: [
                                pw.Text(
                                  'Tiba Kembali',
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                                pw.Text(
                                  ':',
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                                pw.Text(
                                  'Kandangan',
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                              ]),
                              pw.TableRow(children: [
                                pw.Text(
                                  'Pada Tanggal',
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                                pw.Text(
                                  ':',
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                                pw.Text(
                                  tanggalKembali,
                                  style: pw.TextStyle(fontSize: 8),
                                ),
                              ]),
                            ]),
                            pw.Text(
                              'Telah diperiksa dengan keterangan bahwa perjalanan tersebut di atas benar dilakukan atas perintah dan semata-mata untuk kepentingan jabatan dalam waktu yang sesingkat-singkatnya',
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: 20),
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.only(right: 80),
                                child: pw.Column(
                                  children: [
                                    pw.Text('Pengguna Anggaran',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                        )),
                                    pw.SizedBox(height: 60),
                                    pw.Text('Hj. Rahmawaty, ST, MT',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                            fontSize: 8,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text(
                                        'Pembina Utama Muda \nNIP. 197107261997032005',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(fontSize: 8)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Catatan Lain-lain',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(3),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Perhatian',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'Pejabat yang berwenang menerbitkan SPPD, pegawai yang melakukan perjalanan dinas, para pejabat yang mengesahkan tanggal berangkat/tiba serta Bendaharawan bertanggungjawab berdasarkan peraturan-peraturan Keuangan Negara apabila negara mendapat kerugiaan akibat kesalahan dan kealpaannya.',
                            style: pw.TextStyle(fontSize: 8),
                          ),
                          pw.SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ]),
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

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );

  // ignore: use_build_context_synchronously
  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => LaporanSppdPage(path: path),
  //     ));
}
