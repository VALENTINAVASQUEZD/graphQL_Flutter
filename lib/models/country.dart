class Country {
  final String code;
  final String name;
  final String? capital;
  final String? currency;
  final List<String> languages;

  Country({
    required this.code,
    required this.name,
    this.capital,
    this.currency,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      name: json['name'],
      capital: json['capital'],
      currency: json['currency'],
      languages: (json['languages'] as List<dynamic>)
          .map((lang) => lang['name'] as String)
          .toList(),
    );
  }
}