import 'package:aplikasi_kepegawaian/pages/anggaran/report_anggaran.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/report_kegiatan.dart';
import 'package:aplikasi_kepegawaian/pages/kuitansi/report_kuitansi.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/report_pengeluaran.dart';
import 'package:flutter/material.dart';

class Tes extends StatefulWidget {
  const Tes({super.key});

  @override
  State<Tes> createState() => _TesState();
}

class _TesState extends State<Tes> {
  String penyebut(nominal) {
    var nilai = nominal.abs();
    List huruf = [
      "",
      "satu",
      "dua",
      "tiga",
      "empat",
      "lima",
      "enam",
      "tujuh",
      "delapan",
      "sembilan",
      "sepuluh",
      "sebelas"
    ];
    String temp = "";
    if (nilai < 12) {
      temp = "${huruf[nilai.toInt()]}";
    } else if (nilai < 20) {
      temp = "${penyebut(nilai - 10)} belas";
    } else if (nilai < 100) {
      temp = "${penyebut(nilai / 10)} puluh ${penyebut(nilai % 10)}";
    } else if (nilai < 200) {
      temp = "seratus ${penyebut(nilai - 100)}";
    } else if (nilai < 1000) {
      temp = "${penyebut(nilai / 100)} ratus ${penyebut(nilai % 100)}";
    } else if (nilai < 2000) {
      temp = " seribu ${penyebut(nilai - 1000)}";
    } else if (nilai < 1000000) {
      temp = "${penyebut(nilai / 1000)} ribu ${penyebut(nilai % 1000)}";
    } else if (nilai < 1000000000) {
      temp = "${penyebut(nilai / 1000000)} juta ${penyebut(nilai % 1000000)}";
    } else if (nilai < 1000000000000) {
      temp =
          "${penyebut(nilai / 1000000000)} milyar ${penyebut(nilai % 1000000000)}";
    } else if (nilai < 1000000000000000) {
      temp =
          "${penyebut(nilai / 1000000000000)} trilyun ${penyebut(nilai % 1000000000000)}";
    }
    return temp;
  }

  String terbilang(nilai) {
    String hasil = '';
    if (nilai < 0) {
      hasil = "minus ${penyebut(nilai).trim()}";
    } else {
      hasil = penyebut(nilai).trim();
    }

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // laporanAnggaran(context);
            },
            child: Text('Click')),
      ),
    );
  }
}
