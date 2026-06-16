import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/book.dart';
import '../../../services/catalog_service.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../features/catalog/widgets/book_result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _catalogService = CatalogService();
  List<Book> _newArrivals = const [];
  bool _isLoadingNewArrivals = true;
  String? _newArrivalsError;

  @override
  void initState() {
    super.initState();
    _loadNewArrivals();
  }

  Future<void> _loadNewArrivals() async {
    setState(() {
      _isLoadingNewArrivals = true;
      _newArrivalsError = null;
    });

    try {
      final books = await _catalogService.getNewArrivals(limit: 10);
      if (!mounted) return;
      setState(() {
        _newArrivals = books;
        _isLoadingNewArrivals = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _newArrivalsError = 'Unable to load new arrivals.';
        _isLoadingNewArrivals = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _BannerHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsRow(),
                  const SizedBox(height: 24),
                  _buildReminderCard(),
                  const SizedBox(height: 24),
                  SectionTitle(
                    title: 'New Arrivals',
                    actionLabel: 'View all',
                    onAction: () => context.go('/search'),
                  ),
                  const SizedBox(height: 14),
                  _buildNewArrivalsList(context),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivalsList(BuildContext context) {
    if (_isLoadingNewArrivals) {
      return const SizedBox(
        height: 218,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_newArrivalsError != null) {
      return SizedBox(
        height: 218,
        child: Center(
          child: TextButton.icon(
            onPressed: _loadNewArrivals,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(_newArrivalsError!),
          ),
        ),
      );
    }

    if (_newArrivals.isEmpty) {
      return const SizedBox(
        height: 218,
        child: Center(
          child: Text(
            'No new arrivals yet.',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SizedBox(
      height: 218,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _newArrivals.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final book = _newArrivals[index];
          return BookResultCard(
            book: book,
            onTap: () => context.go('/book_details?id=${book.id}'),
          );
        },
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '2',
            label: 'Active Loans',
            icon: Icons.library_books_rounded,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            value: '1',
            label: 'Due Soon',
            icon: Icons.schedule_rounded,
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            value: '0',
            label: 'Overdue',
            icon: Icons.warning_amber_rounded,
            color: AppColors.danger,
          ),
        ),
      ],
    );
  }

  Widget _buildReminderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.schedule_rounded,
              color: AppColors.warning,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due in 2 days',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF92400E),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '"Research Methods" is due on June 17.',
                  style: TextStyle(fontSize: 13, color: Color(0xFFB45309)),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.warning),
        ],
      ),
    );
  }
}

class _BannerHeader extends StatelessWidget {
  const _BannerHeader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        height: 180,
        child: Image.asset(
          'assets/Bannernew.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
