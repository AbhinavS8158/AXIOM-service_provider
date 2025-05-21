import 'package:flutter/material.dart';
import 'package:service_provider/model/properycard_form_model.dart';

class PropertyDetailsProvider with ChangeNotifier {
  PropertycardFormModel _property;

  PropertyDetailsProvider(this._property);

  PropertycardFormModel get property => _property;

  void setProperty(PropertycardFormModel newProperty) {
    _property = newProperty;
    notifyListeners();
  }
}
