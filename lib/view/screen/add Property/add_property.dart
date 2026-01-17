import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/add%20Property/widgets/add_pg_form.dart';
import 'package:service_provider/view/screen/add%20Property/widgets/add_property_appbar.dart';
import 'package:service_provider/view/screen/add%20Property/widgets/add_rental_form.dart';
import 'package:service_provider/view/screen/add%20Property/widgets/add_sell_form.dart';

class AddPoperty extends StatelessWidget {
  const AddPoperty({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.bg,
        appBar: AddPropertyAppBar(),
        body: TabBarView(
          children: [AddRentalForm(), AddSellForm(), AddPgForm()],
        ),
      ),
    );
  }
}
