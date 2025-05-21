// lib/controller/rent_property_provider.dart

import 'package:flutter/material.dart';
import 'package:service_provider/controller/db/pg_property_services.dart';
import 'package:service_provider/model/properycard_form_model.dart';


class PgPropertyProvider with ChangeNotifier {
  final PgPropertyServices _service = PgPropertyServices();

  Stream<List<PropertycardFormModel>> get propertiesStream =>
      _service.getPgProperties();
}
