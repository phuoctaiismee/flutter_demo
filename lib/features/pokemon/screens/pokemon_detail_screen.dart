import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../data/models/pokemon.dart';
import '../data/repositories/pokemon_repository.dart';

class PokemonDetailScreen extends StatefulWidget {
  final String pokemonName;

  const PokemonDetailScreen({super.key, required this.pokemonName});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  final PokemonRepository _pokemonRepository = PokemonRepository();
  PokemonDetail? _pokemonDetail;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPokemonDetail();
  }

  Future<void> _loadPokemonDetail() async {
    try {
      final detail = await _pokemonRepository.getPokemonDetail(widget.pokemonName);
      setState(() {
        _pokemonDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName[0].toUpperCase() + widget.pokemonName.substring(1)),
        centerTitle: true,
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _error != null
              ? _buildErrorState()
              : _buildContent(),
    );
  }

  Widget _buildLoadingState() {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      highlightColor: theme.colorScheme.surfaceVariant,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 300, color: Colors.white),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: List.generate(
                  6,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 12),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(_error ?? 'Unknown error'),
          TextButton(onPressed: _loadPokemonDetail, child: const Text('Thử lại')),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final theme = Theme.of(context);
    final detail = _pokemonDetail!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: InteractiveViewer(
              child: Image.network(
                detail.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${detail.id.toString().padLeft(3, '0')}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: detail.types
                          .map((type) => Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  type.toUpperCase(),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('Chỉ số cơ bản', style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                ...detail.stats.map((stat) => _buildStatRow(stat)),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _buildInfoItem('Cân nặng', '${detail.weight / 10} kg'),
                    const SizedBox(width: 24),
                    _buildInfoItem('Chiều cao', '${detail.height / 10} m'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(PokemonStat stat) {
    final theme = Theme.of(context);
    final String label = _mapStatLabel(stat.name);
    final double percent = stat.value / 150.0 > 1.0 ? 1.0 : stat.value / 150.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.textTheme.bodyMedium),
              Text(stat.value.toString(), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: theme.colorScheme.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5))),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _mapStatLabel(String name) {
    switch (name) {
      case 'hp': return 'HP';
      case 'attack': return 'Tấn công';
      case 'defense': return 'Phòng thủ';
      case 'special-attack': return 'Tấn công đặc biệt';
      case 'special-defense': return 'Phòng thủ đặc biệt';
      case 'speed': return 'Tốc độ';
      default: return name;
    }
  }
}
