import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      PhosphorIcons.house(PhosphorIconsStyle.regular),
      PhosphorIcons.equals(PhosphorIconsStyle.regular),
      PhosphorIcons.heart(PhosphorIconsStyle.regular),
      PhosphorIcons.squaresFour(PhosphorIconsStyle.regular),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(icons.length, (index) {
              final isSelected = selectedIndex == index;

              // ==========================================
              // XÀI HÀNG CHÍNH HÃNG: ICONBUTTON CỦA FLUTTER
              // ==========================================
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuint,
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  // Thuộc tính có sẵn tạo hiệu ứng gợn sóng
                  splashRadius:
                      28, // Độ bự của cái gợn sóng (bằng nửa width/height là vừa khít)
                  splashColor: isSelected
                      ? Colors.black12
                      : Colors.white24, // Màu gợn sóng
                  highlightColor:
                      Colors.transparent, // Tắt màu nền xám mờ đi cho sạch

                  icon: Icon(
                    icons[index],
                    color: isSelected ? Colors.black : Colors.white70,
                    size: 26,
                  ),
                  onPressed: () => onItemTapped(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
