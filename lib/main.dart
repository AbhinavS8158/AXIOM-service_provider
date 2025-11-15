import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/amenities_pg_provider.dart';
import 'package:service_provider/controller/provider/amenity_rental_provider.dart';
import 'package:service_provider/controller/provider/amenity_sell_provider.dart';
import 'package:service_provider/controller/provider/auth/login_provider.dart';
import 'package:service_provider/controller/provider/auth/signup_provider.dart';
import 'package:service_provider/controller/provider/bottom_nav_provider.dart';
import 'package:service_provider/controller/provider/filter_provider.dart';
import 'package:service_provider/controller/provider/location_provider.dart';
import 'package:service_provider/controller/provider/pg_form_provider.dart';
import 'package:service_provider/controller/provider/pg_property_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_pg.dart';
import 'package:service_provider/controller/provider/photo_picker_provider_sell.dart';
import 'package:service_provider/controller/provider/property_list_provider.dart';
import 'package:service_provider/controller/provider/property_type_.dropdown.dart';
import 'package:service_provider/controller/provider/property_type_pg.dart';
import 'package:service_provider/controller/provider/property_type_provider_sell.dart';
import 'package:service_provider/controller/provider/rent_property_provider.dart';
import 'package:service_provider/controller/provider/rental_form_provider.dart';
import 'package:service_provider/controller/provider/sell_form_provider.dart';
import 'package:service_provider/controller/provider/sell_property_provider.dart';
import 'package:service_provider/controller/provider/tab_nav_provider.dart';
import 'package:service_provider/firebase_options.dart';
import 'package:service_provider/view/screen/splash/splash_screen.dart';
import 'package:service_provider/view/screen/widget/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => TabNavProvider()),
        ChangeNotifierProvider(create: (_) => PropertyTypeProvider()),
        ChangeNotifierProvider(create: (_) => PhotoPickerProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => RentalFormProvider()),
        ChangeNotifierProvider(create: (_) => AmenitiesProvider()),
        ChangeNotifierProvider(create: (_) => SellFormProvider()),
        ChangeNotifierProvider(create: (_) => PropertyTypeProviderSell()),
        ChangeNotifierProvider(create: (_) => PhotoPickerProviderSell()),
        ChangeNotifierProvider(create: (_) => AmenitiesSellProvider()),
        ChangeNotifierProvider(create: (_) => PgFormProvider()),
        ChangeNotifierProvider(create: (_) => DropdownPgProvider()),
        ChangeNotifierProvider(create: (_) => AmenitiesPgProvider()),
        ChangeNotifierProvider(create: (_) => PhotoPickerProviderPg()),
        ChangeNotifierProvider(create: (_) => PropertyListProvider()),
        ChangeNotifierProvider(create: (_) => RentPropertyProvider()),
        ChangeNotifierProvider(create: (_) => SellPropertyProvider()),
        ChangeNotifierProvider(create: (_) => PgPropertyProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      
      ],
      child: MaterialApp(
        title: "Axiom",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/home': (context) =>  BottomNav(index: 0),
        },
      ),
    );
  }
}
