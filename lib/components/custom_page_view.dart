import 'package:effah/components/birth_date.dart';
import 'package:effah/components/gender.dart';
import 'package:effah/components/naming.dart';
import 'package:effah/components/nationality_info.dart';
import 'package:effah/components/religion.dart';
import 'package:effah/models/controller_reg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRegisterView extends StatelessWidget {
   CustomRegisterView({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<ControllerReg>(context);
    return PageView(
      controller: ref.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Gender(),
        Naming(),
        BirthDate(),
        NationalityInfo(),
        Religion(id)
      ],
    );
  }
}
