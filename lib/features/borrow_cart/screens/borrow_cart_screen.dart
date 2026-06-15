import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/mock_book.dart';
import '../../../shared/widgets/primary_button.dart';

class BorrowCartScreen extends StatelessWidget {
  const BorrowCartScreen({super.key});

  List<MockBook> get mockCartItems => const [
        MockBook(
          id: '1',
          title: 'Library Science Essentials',
          author: 'Anna Reyes',
          callNumber: 'Z 675 .R49',
          availability: 'Available',
          coverUrl: '',
          year: '2023',
          description: 'Foundations and practice for modern libraries.',
          copies: 5,
          isAvailable: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final cartItems = mockCartItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Borrow Cart')),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: cartItems.isEmpty
              ? const Center(
                  child: Text('Your borrow cart is empty.', style: TextStyle(color: AppColors.textMuted)),
                )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'You may borrow up to 5 items. Select the books you want to request.',
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final book = cartItems[index];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 58,
                                  height: 82,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.book, color: AppColors.primary, size: 32),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(book.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 6),
                                      Text(book.author, style: const TextStyle(color: AppColors.textMuted)),
                                      const SizedBox(height: 10),
                                      Text(book.callNumber, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('3 of 5 items selected', style: TextStyle(color: AppColors.textMuted)),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: 'Submit Request',
                      onPressed: () {},
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
