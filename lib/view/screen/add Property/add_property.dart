import 'package:flutter/material.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/add%20Property/widgets/add_pg_form.dart';
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
        appBar: AppBar(
          title: Text("Add Property"),
          centerTitle: true,
          backgroundColor: AppColor.bg,
          bottom: TabBar(
            indicatorColor: AppColor.forgot,
            labelColor: AppColor.forgot,
            unselectedLabelColor: AppColor.login,
            tabs: const [
              Tab(icon: Icon(Icons.house), text: 'Rental'),
              Tab(icon: Icon(Icons.apartment), text: 'Sell'),
              Tab(icon: Icon(Icons.meeting_room_outlined), text: 'PG'),
            ],
          ),
        ),
        body: TabBarView(
          children: [AddRentalForm(), AddSellForm(), AddPgForm()],
        ),
      ),
    );
  }
}
