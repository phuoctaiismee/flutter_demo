import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonRepository {
  final PokemonService _pokemonService;

  PokemonRepository({PokemonService? pokemonService}) 
      : _pokemonService = pokemonService ?? PokemonService();

  Future<List<Pokemon>> getPokemonList({int offset = 0, int limit = 20}) async {
    // Chỗ này có thể thêm logic Cache (nếu dùng shared_preferences)
    return await _pokemonService.fetchPokemon(offset: offset, limit: limit);
  }

  Future<PokemonDetail> getPokemonDetail(String name) async {
    return await _pokemonService.fetchPokemonDetail(name);
  }
}
