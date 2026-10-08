import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedCategory = 'All';
  String selectedSort = 'Rating';

  final List<String> categories = [
    'All',
    'Fast Food',
    'Pizza',
    'Desi',
    'Drinks',
    'Desserts',
    'Healthy',
  ];

  final List<_Vendor> vendors = const [
    _Vendor(
      name: 'Campus Café',
      category: 'Fast Food',
      rating: 4.8,
      price: 850,
      preparationTime: '15–20 min',
      delivery: true,
      pickup: true,
      isOpen: true,
      image:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=900',
    ),
    _Vendor(
      name: 'Spice Corner',
      category: 'Desi',
      rating: 4.6,
      price: 650,
      preparationTime: '20–25 min',
      delivery: true,
      pickup: true,
      isOpen: true,
      image:
          'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?w=900',
    ),
    _Vendor(
      name: 'Pizza Point',
      category: 'Pizza',
      rating: 4.7,
      price: 1100,
      preparationTime: '20–30 min',
      delivery: true,
      pickup: true,
      isOpen: true,
      image:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=900',
    ),
    _Vendor(
      name: 'Chill Station',
      category: 'Drinks',
      rating: 4.5,
      price: 400,
      preparationTime: '5–10 min',
      delivery: false,
      pickup: true,
      isOpen: true,
      image:
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=900',
    ),
    _Vendor(
      name: 'Sweet Spot',
      category: 'Desserts',
      rating: 4.9,
      price: 550,
      preparationTime: '10–15 min',
      delivery: true,
      pickup: true,
      isOpen: false,
      image:
          'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=900',
    ),
    _Vendor(
      name: 'Green Bowl',
      category: 'Healthy',
      rating: 4.7,
      price: 750,
      preparationTime: '10–15 min',
      delivery: false,
      pickup: true,
      isOpen: true,
      image:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=900',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Vendor> get filteredVendors {
    List<_Vendor> result = List.from(vendors);

    // Category filter
    if (selectedCategory != 'All') {
      result = result
          .where((vendor) => vendor.category == selectedCategory)
          .toList();
    }

    // Search filter
    final search = _searchController.text.trim().toLowerCase();

    if (search.isNotEmpty) {
      result = result.where((vendor) {
        return vendor.name.toLowerCase().contains(search) ||
            vendor.category.toLowerCase().contains(search);
      }).toList();
    }

    // Sort
    if (selectedSort == 'Rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      result.sort((a, b) => a.price.compareTo(b.price));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),

            SliverToBoxAdapter(
              child: _buildSearch(),
            ),

            SliverToBoxAdapter(
              child: _buildCategories(),
            ),

            SliverToBoxAdapter(
              child: _buildVendorHeader(),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),

              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final vendor = filteredVendors[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildVendorCard(vendor),
                    );
                  },

                  childCount: filteredVendors.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'CAMPUS EATS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
              color: AppColors.terracotta,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'What are you\ncraving?',
            style: TextStyle(
              fontSize: 34,
              height: 0.98,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
              color: AppColors.forest,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Discover food from your campus vendors.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),

      child: Container(
        height: 54,

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
        ),

        child: TextField(
          controller: _searchController,

          onChanged: (_) {
            setState(() {});
          },

          decoration: const InputDecoration(
            border: InputBorder.none,

            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.forest,
            ),

            hintText: 'Search food or vendors...',

            hintStyle: TextStyle(
              color: AppColors.muted,
              fontSize: 13,
            ),

            contentPadding: EdgeInsets.symmetric(
              vertical: 17,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: Text(
              'Explore',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 112,

            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              scrollDirection: Axis.horizontal,

              itemCount: categories.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),

              itemBuilder: (context, index) {
                final category = categories[index];

                return _buildCategoryCard(
                  category,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String category,
    int index,
  ) {
    final selected = selectedCategory == category;

    final icons = {
      'All': Icons.grid_view_rounded,
      'Fast Food': Icons.lunch_dining_rounded,
      'Pizza': Icons.local_pizza_rounded,
      'Desi': Icons.restaurant_rounded,
      'Drinks': Icons.local_drink_rounded,
      'Desserts': Icons.cake_rounded,
      'Healthy': Icons.eco_rounded,
    };

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        width: 105,

        decoration: BoxDecoration(
          color: selected
              ? AppColors.forest
              : AppColors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: selected
                ? AppColors.forest
                : const Color(0xFFE8E2D9),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              icons[category],
              size: 28,
              color: selected
                  ? AppColors.cream
                  : AppColors.forest,
            ),

            const SizedBox(height: 9),

            Text(
              category,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: selected
                    ? AppColors.cream
                    : AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // VENDOR HEADER + SORT
  // ============================================================

  Widget _buildVendorHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 14),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'NEARBY VENDORS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.7,
                  color: AppColors.terracotta,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${filteredVendors.length} places to eat',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.charcoal,
                ),
              ),
            ],
          ),

          _buildSortButton(),
        ],
      ),
    );
  }

  Widget _buildSortButton() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          selectedSort = value;
        });
      },

      color: AppColors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: 'Rating',
            child: Text('Sort by Rating'),
          ),
          PopupMenuItem(
            value: 'Price',
            child: Text('Sort by Price'),
          ),
        ];
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [
            const Icon(
              Icons.tune_rounded,
              size: 17,
              color: AppColors.forest,
            ),

            const SizedBox(width: 6),

            Text(
              selectedSort,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),

            const SizedBox(width: 2),

            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // VENDOR CARD
  // ============================================================

  Widget _buildVendorCard(_Vendor vendor) {
    return GestureDetector(
      onTap: () {
        _openVendor(vendor);
      },

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.045),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),

                  child: Image.network(
                    vendor.image,

                    height: 175,
                    width: double.infinity,

                    fit: BoxFit.cover,

                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 175,
                        color: AppColors.sage,

                        child: const Center(
                          child: Icon(
                            Icons.restaurant_rounded,
                            size: 42,
                            color: AppColors.cream,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  top: 14,
                  left: 14,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: vendor.isOpen
                          ? AppColors.forest
                          : AppColors.terracotta,

                      borderRadius: BorderRadius.circular(9),
                    ),

                    child: Text(
                      vendor.isOpen ? 'OPEN' : 'CLOSED',

                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 14,
                  right: 14,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(9),
                    ),

                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.terracotta,
                        ),

                        const SizedBox(width: 3),

                        Text(
                          vendor.rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          vendor.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.charcoal,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 19,
                        color: AppColors.forest,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: AppColors.muted,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        vendor.preparationTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),

                      const SizedBox(width: 16),

                      if (vendor.delivery)
                        _buildAvailability(
                          Icons.delivery_dining_rounded,
                          'Delivery',
                        ),

                      if (vendor.delivery && vendor.pickup)
                        const SizedBox(width: 9),

                      if (vendor.pickup)
                        _buildAvailability(
                          Icons.shopping_bag_outlined,
                          'Pickup',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailability(
    IconData icon,
    String label,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Icon(
          icon,
          size: 15,
          color: AppColors.sage,
        ),

        const SizedBox(width: 3),

        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // VIEW VENDOR
  // ============================================================

  void _openVendor(_Vendor vendor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening ${vendor.name}...',
        ),

        backgroundColor: AppColors.forest,

        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// ================================================================
// VENDOR MODEL
// ================================================================

class _Vendor {
  final String name;
  final String category;
  final double rating;
  final int price;
  final String preparationTime;
  final bool delivery;
  final bool pickup;
  final bool isOpen;
  final String image;

  const _Vendor({
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    required this.preparationTime,
    required this.delivery,
    required this.pickup,
    required this.isOpen,
    required this.image,
  });
}