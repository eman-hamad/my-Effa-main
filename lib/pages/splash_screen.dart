import 'package:effah/models/user_model.dart';
import 'package:flutter/material.dart';

import '../preferences/preferences.dart';
import 'basic_info/options/options.dart';

class SpalshScreen extends StatefulWidget {
  final dynamic currentPage;

  const SpalshScreen({Key? key, this.currentPage}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  late MyUser model;

  @override
  void initState() {
    super.initState();
    _onRefresh();
    if (model != null) {
      if (model.isLogin == 0) {
        Future.delayed(const Duration(seconds: 14), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => widget.currentPage()));
        });
      } else {
        Future.delayed(const Duration(seconds: 14), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Options(
                        gender: model.gender!,
                        id: model.id,
                        progress: 0,
                      )));
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    model = await Preferences.instance.getUserModel();
    setState(() {
      model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/image/spalsh.png"))),
    );
  }
}
