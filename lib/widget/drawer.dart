import 'package:aplikasi_kepegawaian/pages/anggaran/anggaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/homepage/home_page_user.dart';
import 'package:aplikasi_kepegawaian/pages/kegiatan/kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/report_pegawai.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/pengeluaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/laporan_rekap_sppd.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/homepage/home_page.dart';
import '../pages/login/login_page.dart';

class MyDrawer extends StatefulWidget {
  final String id;
  const MyDrawer({
    super.key,
    required this.id,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
        builder: (context, snapshot) {
          return Drawer(
            child: ListView(children: [
              ListTile(
                selected: widget.id == '1' ? true : false,
                onTap: () {
                  if (widget.id != '1') {
                    if (snapshot.data?.get('roles') == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePageUser(),
                        ),
                      );
                    }
                  }
                },
                leading: const FaIcon(
                  FontAwesomeIcons.house,
                  size: 21,
                ),
                title: Text(
                  'Dashboard',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.solidNoteSticky),
                selected: widget.id == '2' ? true : false,
                onTap: () {
                  if (widget.id != '2') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotaDinasPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Nota Dinas',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                selected: widget.id == '3' ? true : false,
                onTap: () {
                  if (widget.id != '3') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SppdPage(),
                      ),
                    );
                  }
                },
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                title: Text(
                  'Surat Perjalanan Dinas',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                selected: widget.id == '4' ? true : false,
                onTap: () {
                  if (widget.id != '4') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SptPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Surat Perintah Tugas',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                selected: widget.id == '5' ? true : false,
                onTap: () {
                  if (widget.id != '5') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnggaranPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Anggaran',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                selected: widget.id == '6' ? true : false,
                onTap: () {
                  if (widget.id != '6') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnggaranPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Kuitansi',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                selected: widget.id == '7' ? true : false,
                onTap: () {
                  if (widget.id != '7') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PengeluaranPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Pengeluaran Rill',
                  style: GoogleFonts.poppins(),
                ),
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  size: 22,
                ),
                selected: widget.id == '8' ? true : false,
                onTap: () {
                  if (widget.id != '8') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KegiatanPage(),
                      ),
                    );
                  }
                },
                title: Text(
                  'Kegiatan Perjalanan Dinas',
                  style: GoogleFonts.poppins(),
                ),
              ),
              snapshot.data?.get('roles') == 'admin'
                  ? ListTile(
                      leading: const FaIcon(FontAwesomeIcons.solidUser),
                      selected: widget.id == '9' ? true : false,
                      onTap: () {
                        if (widget.id != '9') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PegawaiPage(),
                            ),
                          );
                        }
                      },
                      title: Text(
                        'Data Pegawai',
                        style: GoogleFonts.poppins(),
                      ),
                    )
                  : const SizedBox.shrink(),
              snapshot.data?.get('roles') == 'admin'
                  ? ExpansionTile(
                      leading: const FaIcon(FontAwesomeIcons.print),
                      title: const Text('Laporan'),
                      children: [
                        ListTile(
                          onTap: () {
                            laporanRekapSppd();
                          },
                          title: const Text('Cetak Rekapan Perjalanan Dinas'),
                        ),
                        ListTile(
                          onTap: () {
                            reportPegawai();
                          },
                          title: const Text('Cetak Data Pegawai'),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
            ]),
          );
        });
  }
}
