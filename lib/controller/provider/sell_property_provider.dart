import 'package:flutter/widgets.dart';
import 'package:service_provider/controller/db/sell_property_services.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class SellPropertyProvider extends ChangeNotifier{
  final SellPropertyServices _service=SellPropertyServices();
  Stream<List<PropertycardFormModel>>get propertiesStream => _service.getSellProperties();
}