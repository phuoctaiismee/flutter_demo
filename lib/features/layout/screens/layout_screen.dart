import 'package:demo_3/core/components/ui/stacked_carousel.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:demo_3/core/components/ui/input.dart';
import 'package:demo_3/features/layout/widgets/floating_bottom_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  String _selectedCategory = 'All';
  int _currentNavIndex = 0; // Thêm biến lưu vị trí tab hiện tại
  // Thêm mẻ data xịn xò để test Carousel cho đã con mắt
  final List<Map<String, String>> mockTrips = [
    {
      "country": "Brazil",
      "city": "Rio de Janeiro",
      "image":
          "https://images.unsplash.com/photo-1483729558449-99ef09a8c325?q=80&w=800&auto=format&fit=crop",
    },
    {
      "country": "Japan",
      "city": "Kyoto",
      "image":
          "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?q=80&w=800&auto=format&fit=crop",
    },
    {
      "country": "France",
      "city": "Paris",
      "image":
          "https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "country": "Greece",
      "city": "Santorini",
      "image":
          "https://images.unsplash.com/photo-1533105079780-92b9be482077?q=80&w=800&auto=format&fit=crop",
    },
    {
      "country": "USA",
      "city": "New York",
      "image":
          "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=800&auto=format&fit=crop",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        // Bỏ Padding ở đây, cho phép cuộn nội dung lấn ra mép
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ==========================================
              // KHU VỰC 1: CÓ PADDING 24px (Header, Search, Title)
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.5,
                                ),
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

                    // SEARCH BAR area
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
                            prefixIcon: Icon(
                              PhosphorIcons.magnifyingGlass(
                                PhosphorIconsStyle.regular,
                              ),
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {},
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

                    const SizedBox(height: 24),
                    Text(
                      "Search your nexttrip",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // ==========================================
              // KHU VỰC 2: CHIPS (Cuộn ngang, có padding 24px ở 2 đầu)
              // ==========================================
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ), // Padding khéo léo để chip lướt ra sát mép
                child: Row(
                  children: ['All', 'Beach', 'Mountain', 'City', 'Forest'].map((
                    name,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ), // Đổi sang margin phải để các chip cách nhau
                      child: ChoiceChip(
                        label: Text(name),
                        showCheckmark: false,
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.transparent),
                        ),
                        selected: _selectedCategory == name,
                        selectedColor: Colors.black,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: _selectedCategory == name
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                        ),
                        onSelected: (selected) {
                          setState(() => _selectedCategory = name);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32), // Cách ra xíu cho Carousel thở
              // ==========================================
              // KHU VỰC 3: CAROUSEL (Tràn viền 100%, Không Padding)
              // ==========================================
              StackedCarousel(
                height: 380, // Tăng height lên tí cho đúng form dọc của ảnh
                cardWidthFraction:
                    0.75, // Chỉnh cái này để quyết định độ rộng của thẻ chính
                items: mockTrips.map((trip) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        32,
                      ), // Bo góc sâu hơn cho sang
                    ),
                    child: Stack(
                      children: [
                        // 1. Ảnh nền từ Data
                        Positioned.fill(
                          child: Image.network(
                            trip["image"]!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),

                        // 2. Gradient mờ dần từ dưới lên để chữ nổi bật
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [0.0, 0.5],
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 3. Nút Tim góc phải trên
                        const Positioned(
                          top: 20,
                          right: 20,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        // 4. Texts
                        Positioned(
                          bottom: 84, // Đẩy lên nhường chỗ cho nút
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trip["country"]!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                trip["city"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 5. Nút See more
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 56, // Cao hơn xíu cho dễ bấm
                            decoration: ShapeDecoration(
                              color: const Color(
                                0xFF2C2C2C,
                              ).withOpacity(0.9), // Tối nhẹ
                              shape: const StadiumBorder(),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      "See more",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 44,
                                  height: 44,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 50), // Khoảng trống dưới cùng
            ],
          ),
        ),
      ),
      // RÁP BOTTOM NAV BAR VÀO ĐÂY
      bottomNavigationBar: FloatingNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
