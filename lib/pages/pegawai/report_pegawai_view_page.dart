import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ReportPegawaiViewPage extends StatefulWidget {
  final String path;
  const ReportPegawaiViewPage({super.key, required this.path});

  @override
  State<ReportPegawaiViewPage> createState() => _ReportPegawaiViewPageState();
}

class _ReportPegawaiViewPageState extends State<ReportPegawaiViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegawai'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        padding: const EdgeInsets.all(20),
        child: PDFView(
          filePath: widget.path,
          enableSwipe: true,
          autoSpacing: true,
          pageFling: false,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
        ),
      ),
    );
  }
}
