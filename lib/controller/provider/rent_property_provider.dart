import 'package:flutter/widgets.dart';
import 'package:service_provider/controller/db/rent_property_services.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class RentPropertyProvider extends ChangeNotifier{
  final RentPropertyService _service=RentPropertyService();
  Stream<List<PropertycardFormModel>>get propertiesStream => _service.getRentProperties();
}