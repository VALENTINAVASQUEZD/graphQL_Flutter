import 'package:get/get.dart';

import 'package:app_graphql/models/country.dart';
import 'package:app_graphql/services/country_service.dart';

class CountryController extends GetxController {
  final CountryService _countryService = CountryService();

  final RxList<Country> countries = <Country>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    isLoading.value = true;
    error.value = '';

    try {
      final result = await _countryService.getCountries();
      countries.value = result;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}