import 'package:aplikasi_kepegawaian/pages/login/register_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/create_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/edit_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/laporan_nota_dinas.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/account_menu.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/create_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/edit_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/report_pegawai.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotaDinasPage extends StatefulWidget {
  const NotaDinasPage({super.key});

  @override
  State<NotaDinasPage> createState() => _NotaDinasPageState();
}

class _NotaDinasPageState extends State<NotaDinasPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _rowsPerPage = 4;
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
                      "Nota Dinas",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FirestoreQueryBuilder(
                query: FirebaseFirestore.instance
                    .collection('nota_dinas')
                    .orderBy('no_surat', descending: false),
                builder: (context, snapshot, _) {
                  return PaginatedDataTable(
                    rowsPerPage: _rowsPerPage,
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
                        label: Text('Perihal'),
                      ),
                      DataColumn(
                        label: Text('Dasar'),
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
                        label: Text('Status'),
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
              ),
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
      drawer: const MyDrawer(id: '2'),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.data, this.context);
  @override
  final BuildContext context;
  final List<dynamic> data;
  String noSpt = '870/001-KIP/Diskominfo';
  String noSppd = '090/001-LD/Diskominfo';

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
        Text(data[index].data()["no_surat"]),
      ),
      DataCell(
        Text(data[index].data()["nama"]),
      ),
      DataCell(
        Text(data[index].data()["perihal"]),
      ),
      DataCell(
        Text(data[index].data()["dasar"]),
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
      DataCell(Text(
          data[index].data()["verifikasi"] ? 'Verified' : 'Belum Verifikasi')),
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
                    builder: (context) => EditNotaDinasPage(
                        idSuratTugas: data[index].reference.id,
                        noSurat: data[index].data()["no_surat"],
                        pegawai: data[index].data()["nama"],
                        tempatTujuan: data[index].data()["tempat_tujuan"],
                        maksudTujuan: data[index].data()["maksud_tujuan"],
                        perihal: data[index].data()["perihal"],
                        dasar: data[index].data()["dasar"],
                        tanggalBerangkat:
                            data[index].data()["tanggal_berangkat"].toDate(),
                        tanggalKembali:
                            data[index].data()["tanggal_kembali"].toDate()),
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
          data[index].data()["verifikasi"]
              ? ElevatedButton(
                  child: const Text(
                    "Cetak",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    laporanNotaDinas(
                      data[index].data()['no_surat'],
                      data[index].data()['nama'],
                      data[index].data()['perihal'],
                      data[index].data()['dasar'],
                      data[index].data()['maksud_tujuan'],
                      data[index].data()['tempat_tujuan'],
                      data[index].data()['maksud_tujuan'],
                      formatDate(data[index].data()['tanggal_berangkat'])
                          .toString(),
                      formatDate(data[index].data()['tanggal_kembali'])
                          .toString(),
                      hitungHari(data[index].data()['tanggal_kembali'],
                          data[index].data()['tanggal_berangkat']),
                      formatDate(data[index].data()['send_time']).toString(),
                    );
                  },
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 8,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data?.get('roles') == 'admin') {
                data[index].data()['verifikasi']
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent),
                        onPressed: () async {
                          showAlertVerifikasi(
                              context,
                              data[index].reference.id,
                              data[index].data()['nama'],
                              data[index].data()['maksud_tujuan'],
                              data[index].data()['tempat_tujuan'],
                              data[index].data()['tanggal_berangkat'],
                              data[index].data()['tanggal_kembali'],
                              data[index].data()['userId']);
                        },
                        child: const Text(
                          "Verifikasi",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
              }
              return SizedBox.shrink();
            },
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
      await FirebaseFirestore.instance
          .collection('nota_dinas')
          .doc(id)
          .delete();

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
    print(tglKembali);
    print(tglBerangkat);
    print(hari.toString());

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

  void getNoSuratSpt() async {
    var snap = await FirebaseFirestore.instance
        .collection('spt')
        .orderBy('send_time', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isNotEmpty) {
      String data = snap.docs[0]["no_spt"];
      data = data.substring(4, 7);
      int noSurat = int.parse(data);
      noSurat += 1;
      data = noSurat.toString().padLeft(3, '0');
      noSpt = "870/$data-KIP/Diskominfo";
    } else {
      noSpt = "870/001-KIP/Diskominfo";
    }
  }

  Future getNoSuratSppd() async {
    var snap = await FirebaseFirestore.instance
        .collection('sppd')
        .orderBy('send_time', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isNotEmpty) {
      String data = snap.docs[0]["no_sppd"];
      data = data.substring(4, 7);
      int noSurat = int.parse(data);
      noSurat += 1;
      data = noSurat.toString().padLeft(3, '0');
      noSppd = "090/$data-LD/DisKominfo";
    } else {
      noSppd = "090/001-LD/DisKominfo";
    }
  }

  Future<void> buatSptSppd(
    id,
    nama,
    maksudTujuan,
    tempatTujuan,
    tglBerangkat,
    tglKembali,
    userId,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('spt').add({
        'no_spt': noSpt,
        'nama': nama,
        'maksud_tujuan': maksudTujuan,
        'tempat_tujuan': tempatTujuan,
        'alat_transportasi': 'Mobil Dinas',
        'tanggal_berangkat': tglBerangkat,
        'tanggal_kembali': tglKembali,
        'userId': userId,
        'send_time': DateTime.now(),
      });
      await FirebaseFirestore.instance.collection('sppd').add({
        'no_sppd': noSppd,
        'nama': nama,
        'maksud_tujuan': maksudTujuan,
        'tempat_tujuan': tempatTujuan,
        'alat_transportasi': 'Mobil Dinas',
        'tanggal_berangkat': tglBerangkat,
        'tanggal_kembali': tglKembali,
        'keterangan_lain': "",
        'userId': userId,
        'send_time': DateTime.now(),
      });
      await FirebaseFirestore.instance.collection('nota_dinas').doc(id).update(
        {'verifikasi': true},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
        buatSptSppd(
          id,
          nama,
          maksudTujuan,
          tempatTujuan,
          tglBerangkat,
          tglKembali,
          userId,
        );
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
