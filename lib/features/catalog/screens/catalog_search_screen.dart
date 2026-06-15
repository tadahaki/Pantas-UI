import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/mock_book.dart';
import '../widgets/book_result_card.dart';
import '../../catalog/widgets/catalog_filter_sheet.dart';

class CatalogSearchScreen extends StatefulWidget {
  const CatalogSearchScreen({super.key});

  @override
  State<CatalogSearchScreen> createState() => _CatalogSearchScreenState();
}

class _CatalogSearchScreenState extends State<CatalogSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedSegment = 'Books';
  final List<MockBook> mockBooks = const [
    MockBook(
      id: '1',
      title: 'Library Science Essentials',
      author: 'Anna Reyes',
      callNumber: 'Z 675 .R49',
      availability: 'Available',
      coverUrl: '',
      year: '2023',
      description: 'Foundations and practice for modern libraries.',
      copies: 4,
      isAvailable: true,
    ),
    MockBook(
      id: '2',
      title: 'Philippine History for Students',
      author: 'Jose Rizal Jr.',
      callNumber: 'DS 653 .H58',
      availability: 'Checked Out',
      coverUrl: '',
      year: '2021',
      description: 'A user-friendly guide to local history.',
      copies: 0,
      isAvailable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBooks = mockBooks
        .where((book) => book.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Catalog Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search books, authors, subjects',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => const CatalogFilterSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.card,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ToggleButtons(
                borderRadius: BorderRadius.circular(14),
                isSelected: ['Books', 'E-books'].map((value) => value == selectedSegment).toList(),
                onPressed: (index) {
                  setState(() {
                    selectedSegment = index == 0 ? 'Books' : 'E-books';
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Text('Books'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Text('E-books'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (filteredBooks.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No results found. Try a different search term.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredBooks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookResultCard(
                        book: book,
                        onTap: () {
                          context.go('/book_details?id=${book.id}');
                        },
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
