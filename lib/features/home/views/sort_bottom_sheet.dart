import 'package:flutter/material.dart';

enum SortOption {
  all,
  ageElder,
  ageYounger,
}

class SortBottomSheet extends StatelessWidget {
  final SortOption currentSort;

  const SortBottomSheet({
    super.key,
    this.currentSort = SortOption.all,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        SortOption selectedSort = currentSort;

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
                context: context,
                setState: setState,
                title: 'All',
                value: SortOption.all,
                selectedSort: selectedSort,
                onSelect: (value) {
                  selectedSort = value;
                },
              ),
              const SizedBox(height: 16),
              _buildSortOption(
                context: context,
                setState: setState,
                title: 'Age: Elder',
                value: SortOption.ageElder,
                selectedSort: selectedSort,
                onSelect: (value) {
                  selectedSort = value;
                },
              ),
              const SizedBox(height: 16),
              _buildSortOption(
                context: context,
                setState: setState,
                title: 'Age: Younger',
                value: SortOption.ageYounger,
                selectedSort: selectedSort,
                onSelect: (value) {
                  selectedSort = value;
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required StateSetter setState,
    required String title,
    required SortOption value,
    required SortOption selectedSort,
    required Function(SortOption) onSelect,
  }) {
    final isSelected = selectedSort == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          onSelect(value);
        });
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
