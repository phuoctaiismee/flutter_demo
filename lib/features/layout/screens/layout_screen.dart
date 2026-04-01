import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/components/ui/input.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // HEADER Area
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Vanessa',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome to TripGlide',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    'https://api.dicebear.com/7.x/avataaars/png?seed=Felix',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // SEARCH BAR area with Custom SVG (Figma export) and Phosphor Icon
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: AppInput(
                    placeholder: 'Search for places...',
                    borderRadius: 32,
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      right: 60,
                      top: 16,
                      bottom: 16,
                    ),
                    // SỬ DỤNG ICON TỪ FIGMA (SVG)
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/custom_search.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      // SỬ DỤNG PHOSPHOR ICON
                      icon: Icon(
                        PhosphorIcons.slidersHorizontal(
                          PhosphorIconsStyle.regular,
                        ),
                        color: theme.colorScheme.surface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // COMPARISON SECTION
            Text(
              'Icon Styles Comparison',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconSample(context, Icons.search, 'Material (Old)'),
                _buildIconSample(
                  context,
                  PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
                  'Phosphor (Modern)',
                ),
              ],
            ),

            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'Custom Figma Export (SVG)',
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/custom_search.svg',
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSample(
    BuildContext context,
    dynamic iconData,
    String label,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Icon(iconData, size: 28, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
