import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../data/repositories/mock_data_repository.dart';
import '../widgets/genre_card.dart';
import '../widgets/search_bar_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mockRepo = MockDataRepository();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: _onSearchChanged,
              autofocus: false,
            ),
            if (_isSearching)
              // Search Results
              Expanded(
                child: _buildSearchResults(),
              )
            else
              // Browse Categories
              Expanded(
                child: _buildBrowseCategories(mockRepo),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    // In a real app, you would fetch search results based on _searchQuery
    return const Center(
      child: Text(
        'Search not implemented in this demo',
        style: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildBrowseCategories(MockDataRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(AppConstants.paddingM),
          child: Text(
            'Browse All',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppConstants.paddingM,
              crossAxisSpacing: AppConstants.paddingM,
              childAspectRatio: 1.5,
            ),
            itemCount: repo.genres.length,
            itemBuilder: (context, index) {
              final genre = repo.genres[index];
              return GenreCard(
                genre: genre,
                onTap: () {
                  // Navigate to genre details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped on ${genre.name}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
} 