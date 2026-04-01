import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../../../../core/config/app_config.dart';

class PokemonService {
  final String _baseUrl = AppConfig.pokemonApiUrl;

  Future<List<Pokemon>> fetchPokemon({int offset = 0, int limit = 20}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pokemon detail');
    }
  }
}
