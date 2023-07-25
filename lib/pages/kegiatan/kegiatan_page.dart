import 'package:aplikasi_kepegawaian/pages/kegiatan/create_kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/edit_kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/report_kegiatan.dart';
import 'package:aplikasi_kepegawaian/pages/login/register_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/create_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/edit_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/laporan_nota_dinas.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/show_photo_page.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/create_pengeluaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/edit_pengeluaran_page.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class KegiatanPage extends StatefulWidget {
  const KegiatanPage({super.key});

  @override
  State<KegiatanPage> createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
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
                      "Kegiatan Perjalanan Dinas",
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
                              .collection('kegiatan')
                              .orderBy('no_sppd', descending: false)
                          : FirebaseFirestore.instance
                              .collection('kegiatan')
                              .where('userId',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser?.uid)
                              .orderBy('no_sppd', descending: false),
                      builder: (context, snapshot, _) {
                        return PaginatedDataTable(
                          rowsPerPage: rowsPerPage,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('No'),
                            ),
                            DataColumn(
                              label: Text('No Sppd'),
                            ),
                            DataColumn(
                              label: Text('Nama'),
                            ),
                            DataColumn(
                              label: Text('Kegiatan'),
                            ),
                            DataColumn(
                              label: Text('Tanggal'),
                            ),
                            DataColumn(
                              label: Text('Keterangan'),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.grey)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(0, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      child: const Text("Tambah Kegiatan"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CreateKegiatanPage();
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
      drawer: const MyDrawer(id: '8'),
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
      DataCell(StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sppd')
            .where('no_sppd', isEqualTo: data[index].data()["no_sppd"])
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return Text(snapshot.data?.docs[0]['nama']);
          }
        },
      )),
      DataCell(SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < data[index].data()["kegiatan"].length; i++)
              Text('${i + 1}. ${data[index].data()["kegiatan"][i]}')
          ],
        ),
      )),
      DataCell(SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < data[index].data()["kegiatan"].length; i++)
              Text('${i + 1}. ${formatDate(data[index].data()["tanggal"][i])}'),
          ],
        ),
      )),
      DataCell(SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < data[index].data()["keterangan"].length; i++)
              Text(
                  '${i + 1}. ${data[index].data()["keterangan"][i].toString()}')
          ],
        ),
      )),
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
                      builder: (context) => EditKegiatanPage(
                            idKegiatan: data[index].reference.id,
                            noSppd: data[index].data()["no_sppd"],
                            keterangan: data[index].data()["keterangan"],
                            tanggal: data[index].data()["tanggal"],
                            kegiatan: data[index].data()["kegiatan"],
                          )));
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
              laporanKegiatan(
                data[index].data()["no_sppd"],
                data[index].data()["kegiatan"],
                data[index].data()["tanggal"],
                data[index].data()["keterangan"],
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
      await FirebaseFirestore.instance.collection('kegiatan').doc(id).delete();

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

  Widget verticalDivider = const VerticalDivider(
    color: Colors.black,
    thickness: 1,
  );

  // Future<void> buatSptSppd(
  //   id,
  //   nama,
  //   maksudTujuan,
  //   tempatTujuan,
  //   tglBerangkat,
  //   tglKembali,
  //   userId,
  // ) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('spt').add({
  //       'no_spt': noSpt,
  //       'nama': nama,
  //       'maksud_tujuan': maksudTujuan,
  //       'tempat_tujuan': tempatTujuan,
  //       'alat_transportasi': 'Mobil Dinas',
  //       'tanggal_berangkat': tglBerangkat,
  //       'tanggal_kembali': tglKembali,
  //       'userId': userId,
  //       'send_time': DateTime.now(),
  //     });
  //     await FirebaseFirestore.instance.collection('sppd').add({
  //       'no_sppd': noSppd,
  //       'nama': nama,
  //       'maksud_tujuan': maksudTujuan,
  //       'tempat_tujuan': tempatTujuan,
  //       'alat_transportasi': 'Mobil Dinas',
  //       'tanggal_berangkat': tglBerangkat,
  //       'tanggal_kembali': tglKembali,
  //       'keterangan_lain': "",
  //       'userId': userId,
  //       'send_time': DateTime.now(),
  //     });
  //     await FirebaseFirestore.instance.collection('nota_dinas').doc(id).update(
  //       {'verifikasi': true},
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  showAlertVerifikasi(
    BuildContext context,
    id,
    nama,
    maksudTujuan,
    tempatTujuan,
    tglBerangkat,
    tglKembali,
    userId,
  ) {
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Verifikasi",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        // buatSptSppd(
        //   id,
        //   nama,
        //   maksudTujuan,
        //   tempatTujuan,
        //   tglBerangkat,
        //   tglKembali,
        //   userId,
        // );
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Verifikasi Data Ini?"),
      content: const Text("Verifikasi data ini?"),
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
}
