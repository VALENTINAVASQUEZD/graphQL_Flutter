import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_graphql/controllers/country_controller.dart';
import 'package:app_graphql/screens/country_detail_screen.dart';
import 'package:app_graphql/widgets/country_card.dart';

class HomeScreen extends StatelessWidget {
  final CountryController countryController = Get.find<CountryController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Países'),
        backgroundColor: Colors.orange,
        elevation: 2,
      ),
      body: RefreshIndicator(
        onRefresh: () => countryController.fetchCountries(),
        child: Obx(() {
          if (countryController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (countryController.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${countryController.error.value}',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => countryController.fetchCountries(),
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (countryController.countries.isEmpty) {
            return Center(child: Text('No hay países disponibles'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: countryController.countries.length,
              itemBuilder: (context, index) {
                final country = countryController.countries[index];
                return CountryCard(
                  country: country,
                  onTap: () {
                    Get.to(() => CountryDetailScreen(country: country));
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}
