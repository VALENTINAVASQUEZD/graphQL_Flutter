import 'package:flutter/material.dart';
import 'package:app_graphql/config/graphql_config.dart';

import 'package:app_graphql/models/country.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryService {
  static final ValueNotifier<GraphQLClient> _client =
      GraphQLConfig.clientToQuery();

  static String getCountriesQuery = '''
    query {
      countries {
        code
        name
        capital
        currency
        languages {
          name
        }
      }
    }
  ''';

  Future<List<Country>> getCountries() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(getCountriesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final QueryResult result = await _client.value.query(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final List<dynamic> countriesData = result.data?['countries'] ?? [];
      return countriesData.map((data) => Country.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Error fetching countries: $e');
    }
  }
}