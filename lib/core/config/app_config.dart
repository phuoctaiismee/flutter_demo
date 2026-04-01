class AppConfig {
  static const String appName = String.fromEnvironment('APP_NAME', defaultValue: 'SATREPS App');
  static const String pokemonApiUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://pokeapi.co/api/v2');
  static const String apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
  static const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
}
