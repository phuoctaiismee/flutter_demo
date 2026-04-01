class Pokemon {
  final String name;
  final String url;
  final String imageUrl;

  Pokemon({required this.name, required this.url, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final String url = json['url'];

    final segments = url.split('/');
    final String id = segments[segments.length - 2];
    final String imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Pokemon(name: name, url: url, imageUrl: imageUrl);
  }
}

class PokemonDetail {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> types;
  final List<PokemonStat> stats;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          json['sprites']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      stats: (json['stats'] as List)
          .map((stat) => PokemonStat.fromJson(stat))
          .toList(),
    );
  }
}

class PokemonStat {
  final String name;
  final int value;

  PokemonStat({required this.name, required this.value});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(name: json['stat']['name'], value: json['base_stat']);
  }
}
