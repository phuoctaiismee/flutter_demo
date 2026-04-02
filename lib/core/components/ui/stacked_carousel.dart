import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class StackedCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double cardWidthFraction;

  const StackedCarousel({
    super.key,
    required this.items,
    this.height = 450.0,
    this.cardWidthFraction = 0.82, // Card to ra một xíu để nhìn rõ chiều sâu
  });

  @override
  State<StackedCarousel> createState() => _StackedCarouselState();
}

class _StackedCarouselState extends State<StackedCarousel> {
  late PageController _pageController;
  final int _initialPage = 1000; // Mẹo Infinite Loop
  late double _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = _initialPage.toDouble();
    _pageController = PageController(
      viewportFraction: 0.35, // Độ nhạy vuốt vừa phải để cảm nhận animation
      initialPage: _initialPage,
    );
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final cardWidth = maxWidth * widget.cardWidthFraction;
          final defaultLeft = (maxWidth - cardWidth) / 2;

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ClipRect(
              clipBehavior: Clip.hardEdge,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // LỚP 1: Bắt sự kiện vuốt
                  PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => const SizedBox.shrink(),
                  ),

                  // LỚP 2: Render UI & Animations
                  IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        int currentInt = _currentPage.round();
                        List<int> drawOrder = [];

                        // Lấy 5 item lân cận để xử lý mượt lúc vuốt qua lại
                        for (int i = currentInt - 2; i <= currentInt + 2; i++) {
                          drawOrder.add(i);
                        }

                        // CHIỀU SÂU Z-INDEX ĐỘNG:
                        // Thẻ nào XA TÂM NHẤT thì vẽ TRƯỚC (Nằm dưới đáy)
                        // Thẻ nào GẦN TÂM NHẤT thì vẽ SAU (Trồi lên trên)
                        drawOrder.sort((a, b) {
                          double distA = (a - _currentPage).abs();
                          double distB = (b - _currentPage).abs();
                          return distB.compareTo(distA);
                        });

                        return Stack(
                          clipBehavior: Clip.none,
                          children: drawOrder.map((index) {
                            return _buildCard(index, cardWidth, defaultLeft);
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(int index, double cardWidth, double defaultLeft) {
    double relativePosition = index - _currentPage;
    double absPos = relativePosition.abs();
    int realIndex = index % widget.items.length;
    if (realIndex < 0) realIndex += widget.items.length;

    // ==========================================
    // MẸO CHỐT HẠ: CHỈ HIỂN THỊ ĐÚNG 3 ITEM
    // Bằng cách khóa (clamp) thông số của các item > 1
    // ==========================================

    // Nếu absPos > 1 (Tức là các thẻ thứ 4, thứ 5), nó sẽ bị ép thông số y hệt như thẻ 1
    // -> Núp hoàn toàn sau lưng thẻ Prev/Next, không lòi ra tẹo nào!
    double clampedAbsPos = absPos.clamp(0.0, 1.0);
    double sign = relativePosition < 0 ? -1 : 1;

    // 1. xOffset: Vuốt tới đâu mượt tới đó, max ló ra 14%
    double xOffset = sign * clampedAbsPos * (cardWidth * 0.14);

    // 2. yOffset: Tạo chiều sâu rớt xuống
    double yOffset = clampedAbsPos * 25.0;

    // 3. Scale: Thu nhỏ để tạo phối cảnh 3D
    double scale = 1.0 - (clampedAbsPos * 0.12);

    // 4. Opacity Fade:
    // Khi thẻ ra khỏi vùng vị trí số 1, lập tức fade mờ thành 0 để biến mất
    double opacity = 1.0;
    if (absPos > 1.0) {
      // Ví dụ: absPos = 1.0 -> opacity = 1.0. absPos = 1.5 -> opacity = 0.0
      opacity = (1.0 - (absPos - 1.0) * 2).clamp(0.0, 1.0);
    }

    return Positioned(
      left: defaultLeft + xOffset,
      top: yOffset,
      bottom: 0,
      width: cardWidth,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: Opacity(opacity: opacity, child: widget.items[realIndex]),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
