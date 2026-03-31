import 'package:flutter/material.dart';

enum SortOption {
  all,
  ageElder,
  ageYounger,
}

class SortBottomSheet extends StatefulWidget {
  final SortOption currentSort;

  const SortBottomSheet({
    super.key,
    this.currentSort = SortOption.all,
  });

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late SortOption _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sort',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          _buildSortOption(
            title: 'All',
            value: SortOption.all,
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            title: 'Age: Elder',
            value: SortOption.ageElder,
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            title: 'Age: Younger',
            value: SortOption.ageYounger,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSortOption({
    required String title,
    required SortOption value,
  }) {
    final isSelected = _selectedSort == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = value;
        });
        // Return the selected option after a short delay for visual feedback
        Future.delayed(const Duration(milliseconds: 200), () {
          Navigator.of(context).pop(value);
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF0B8EFF) : Colors.grey[400]!,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF0B8EFF),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
