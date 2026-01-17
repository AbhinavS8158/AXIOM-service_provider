import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/pg_property_provider.dart';
import 'package:service_provider/utils/app_color.dart';
import 'package:service_provider/view/screen/pgProperty%20List/widget/property_sliver_appbar.dart';
import 'package:service_provider/view/screen/pgProperty%20List/widget/property_sliver_list.dart';
import 'package:service_provider/view/screen/pgProperty%20List/widget/sliver_searchbar.dart';
import 'package:service_provider/view/screen/widget/property_card_pg.dart';

class PgPropertList extends StatelessWidget {
  const PgPropertList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PgPropertyProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: CustomScrollView(
        slivers: [
          // 🔹 Custom Sliver App Bar
          PropertySliverAppBar(),

          // 🔹 Search and Filter Section
          SliverSearchBar(
      onChanged: (value) {
        // filter properties
      },
    ),

          // 🔹 Properties List
          PropertiesSliverList(
  stream: provider.propertiesStream,
  itemBuilder: (property) => PropertyCardPg(property: property),
),


          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
