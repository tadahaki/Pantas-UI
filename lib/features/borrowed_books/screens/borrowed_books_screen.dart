import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/status_badge.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({super.key});

  @override
  State<BorrowedBooksScreen> createState() => _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  String selectedTab = 'Current';

  final List<Map<String, dynamic>> currentBooks = const [
    {
      'title': 'Research Methods',
      'author': 'Carlo Lopez',
      'dueDate': '2026-06-17',
      'status': 'Due soon',
      'overdue': false,
    },
  ];

  final List<Map<String, dynamic>> historyBooks = const [
    {
      'title': 'Media and Society',
      'author': 'Erika Tan',
      'dueDate': '2026-05-10',
      'status': 'Returned',
      'overdue': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final books = selectedTab == 'Current' ? currentBooks : historyBooks;

    return Scaffold(
      appBar: AppBar(title: const Text('My Borrowed Books')),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ToggleButtons(
                borderRadius: BorderRadius.circular(14),
                isSelected: ['Current', 'History'].map((e) => e == selectedTab).toList(),
                onPressed: (index) => setState(() {
                  selectedTab = index == 0 ? 'Current' : 'History';
                }),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Current'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('History'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: books.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(book['author'] as String, style: const TextStyle(color: AppColors.textMuted)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              StatusBadge(
                                label: book['status'] as String,
                                color: book['overdue'] as bool ? AppColors.danger : AppColors.warning,
                              ),
                              const Spacer(),
                              Text('Due ${book['dueDate'] as String}', style: const TextStyle(color: AppColors.textMuted)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Fine/Status', style: TextStyle(color: AppColors.textMuted)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
