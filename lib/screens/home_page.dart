import 'package:bijak_assignment/widgets/category_list.dart';
import 'package:bijak_assignment/widgets/horizontal_product_list.dart';
import 'package:bijak_assignment/widgets/image_banners.dart';
import 'package:bijak_assignment/widgets/mini_cart_nudge.dart';
import 'package:bijak_assignment/widgets/search_bar.dart';
import 'package:bijak_assignment/widgets/vertical_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        title: const Text(
          'Bijak',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _isLoading ? _buildLoading() : _buildContent(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MiniCartNudge(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            width: double.infinity,
            height: 200.0,
            color: Colors.white,
          ),
        ),
        itemCount: 6,
      ),
    );
  }

  Widget _buildContent() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(),
            SizedBox(height: 16),
            ImageBanners(),
            SizedBox(height: 16),
            CategoryList(),
            SizedBox(height: 16),
            HorizontalProductList(),
            SizedBox(height: 16),
            VerticalProductList(),
          ],
        ),
      ),
    );
  }
}
