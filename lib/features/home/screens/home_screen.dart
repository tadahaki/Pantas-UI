import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/models/mock_book.dart';
import '../../../features/catalog/widgets/book_result_card.dart';
import '../../../shared/widgets/status_badge.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<MockBook> get mockNewArrivals => const [
        MockBook(
          id: '1',
          title: 'Introduction to Filipino Studies',
          author: 'Maria Dela Cruz',
          callNumber: 'QA 650 .D45',
          availability: 'Available',
          coverUrl: '',
          year: '2022',
          description: 'A modern guide to Philippine culture and literature.',
          copies: 5,
          isAvailable: true,
        ),
        MockBook(
          id: '2',
          title: 'Digital Libraries in Education',
          author: 'Juan Santos',
          callNumber: 'Z 678 .S26',
          availability: 'Available',
          coverUrl: '',
          year: '2023',
          description: 'Strategies for managing digital collections in schools.',
          copies: 3,
          isAvailable: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good afternoon, Ana',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Here is your library companion for today.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    decoration: InputDecoration(
                      hintText: 'Search catalog',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildQuickAction(context, Icons.search, 'Catalog', '/search'),
                      _buildQuickAction(context, Icons.book, 'Borrowed', '/borrowed'),
                      _buildQuickAction(context, Icons.meeting_room, 'Rooms', '/room_reservation'),
                      _buildQuickAction(context, Icons.notifications, 'Alerts', '/notifications'),
                      _buildQuickAction(context, Icons.person, 'Profile', '/profile'),
                      _buildQuickAction(context, Icons.feedback, 'Feedback', '/feedback'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reminder',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            StatusBadge(label: 'Due soon', color: AppColors.warning),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Your copy of "Research Methods" is due in 2 days.',
                                style: TextStyle(color: AppColors.textMuted),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'New arrivals', actionLabel: 'View all'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: mockNewArrivals.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final book = mockNewArrivals[index];
                        return BookResultCard(
                          book: book,
                          onTap: () {
                            Navigator.pushNamed(context, '/book_details', arguments: {'id': book.id});
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, String route) {
    final width = MediaQuery.of(context).size.width / 2 - 28;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () => context.go(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.card,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
