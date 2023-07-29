import 'package:aplikasi_kepegawaian/pages/nota_dinas/create_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/edit_sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/laporan_sppd.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SppdPage extends StatefulWidget {
  const SppdPage({super.key});

  @override
  State<SppdPage> createState() => _SppdPageState();
}

class _SppdPageState extends State<SppdPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rowsPerPage = 8;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.bars),
          iconSize: 30,
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Surat Perintah Perjalanan Dinas",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return FirestoreQueryBuilder(
                      query: snapshot.data?.get('roles') != 'user'
                          ? FirebaseFirestore.instance
                              .collection('sppd')
                              .orderBy('no_sppd', descending: false)
                          : FirebaseFirestore.instance.collection('sppd').where(
                              'userId',
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        ..orderBy('no_sppd', descending: false),
                      builder: (context, snapshot, _) {
                        return PaginatedDataTable(
                          rowsPerPage: rowsPerPage,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('No'),
                            ),
                            DataColumn(
                              label: Text('No Surat'),
                            ),
                            DataColumn(
                              label: Text('Nama'),
                            ),
                            DataColumn(
                              label: Text('Maksud Tujuan'),
                            ),
                            DataColumn(
                              label: Text('Tempat Tujuan'),
                            ),
                            DataColumn(
                              label: Text('Tanggal Berangkat'),
                            ),
                            DataColumn(
                              label: Text('Tanggal Kembali'),
                            ),
                            DataColumn(
                              label: Text('Alat Transportasi'),
                            ),
                            DataColumn(
                              label: Text('Keterangan Lain-lain'),
                            ),
                            DataColumn(
                              label: Text('Action'),
                            ),
                          ],
                          onPageChanged: (int? n) {
                            snapshot.fetchMore();
                          },
                          source: MyData(snapshot.docs, context),
                        );
                      },
                    );
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: const Border(top: BorderSide(color: Colors.grey)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(0, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      child: const Text("Tambah Nota Dinas"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CreateNotaDinasPage();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(id: '3'),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.data, this.context);
  final BuildContext context;
  final List<dynamic> data;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(
        Text(data[index].data()["no_sppd"]),
      ),
      DataCell(
        Text(data[index].data()["nama"]),
      ),
      DataCell(
        SizedBox(
          width: 300,
          child: Text(
            data[index].data()["maksud_tujuan"],
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ),
      DataCell(
        Text(data[index].data()["tempat_tujuan"]),
      ),
      DataCell(
        Text(
          formatDate(data[index].data()["tanggal_berangkat"]),
        ),
      ),
      DataCell(
        Text(
          formatDate(data[index].data()["tanggal_kembali"]),
        ),
      ),
      DataCell(
        Text(data[index].data()["alat_transportasi"]),
      ),
      DataCell(
        Text(data[index].data()["keterangan_lain"]),
      ),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSppdPage(
                      idSuratTugas: data[index].reference.id,
                      noSurat: data[index].data()["no_sppd"],
                      pegawai: data[index].data()["nama"],
                      tempatTujuan: data[index].data()["tempat_tujuan"],
                      maksudTujuan: data[index].data()["maksud_tujuan"],
                      tanggalBerangkat:
                          data[index].data()["tanggal_berangkat"].toDate(),
                      tanggalKembali:
                          data[index].data()["tanggal_kembali"].toDate(),
                      transportasi: data[index].data()["alat_transportasi"],
                      keterangan: data[index].data()["keterangan_lain"],
                    ),
                  ));
            },
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              showAlertHapus(context, data[index].reference.id);
            },
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
            child: const Text(
              "Cetak",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              laporanSppd(
                context,
                data[index].data()['no_sppd'],
                data[index].data()['nama'],
                data[index].data()['maksud_tujuan'],
                data[index].data()['tempat_tujuan'],
                formatDate(data[index].data()['tanggal_berangkat']).toString(),
                formatDate(data[index].data()['tanggal_kembali']).toString(),
                hitungHari(data[index].data()['tanggal_kembali'],
                    data[index].data()['tanggal_berangkat']),
                data[index].data()['alat_transportasi'],
                data[index].data()['keterangan_lain'],
                formatDate(data[index].data()['send_time']).toString(),
              );
            },
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      )),
    ]);
  }

  showAlertHapus(BuildContext context, id) {
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Hapus",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () {
        deleteData(id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Hapus Data Ini?"),
      content: const Text(
          "Yakin ingin menghapus data ini? Data akan dihapus secara permanen"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteData(id) async {
    try {
      await FirebaseFirestore.instance.collection('sppd').doc(id).delete();

      Fluttertoast.showToast(
          msg: "Data Berhasil Dihapus",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print(e);
    }
  }

  String hitungHari(tglKembali, tglBerangkat) {
    tglKembali = tglKembali.toDate();
    tglBerangkat = tglBerangkat.toDate();
    var hari = tglKembali.difference(tglBerangkat).inDays + 1;

    return hari.toString();
  }

  String formatDate(date) {
    return DateFormat(
      'd MMMM yyyy',
      'id',
    ).format(date.toDate());
  }
}
