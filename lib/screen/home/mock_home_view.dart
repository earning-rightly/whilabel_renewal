import 'package:flutter/material.dart';
import 'package:whilabel_renewal/screen/barcode_scanner/barcode_scanner_view.dart';
import 'package:whilabel_renewal/screen/my_page/setting_view/setting_view.dart';

/** 개발할때 사용할 임시 Home view */
class MockHomeView extends StatelessWidget {
  const MockHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingView()));
                  },
                  child: Text("setting view")),
              SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BarcodeScannerView()));
                  },
                  child: Text("scanner"))
            ],
          ),
        ),
      ),
    );
  }
}
