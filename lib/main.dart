import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductCatalog(),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final Color color;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.color,
  });
}

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Noise cancelling wireless headphones with premium sound quality',
      price: 199.99,
      imageUrl: '🎧',
      color: Colors.blue.shade100,
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      description: 'Fitness tracker with heart rate monitor and GPS',
      price: 299.99,
      imageUrl: '⌚',
      color: Colors.green.shade100,
    ),
    Product(
      id: '3',
      name: 'Laptop Stand',
      description: 'Adjustable aluminum laptop stand for ergonomic computing',
      price: 89.99,
      imageUrl: '💻',
      color: Colors.orange.shade100,
    ),
    Product(
      id: '4',
      name: 'Desk Lamp',
      description: 'LED desk lamp with adjustable brightness and color temperature',
      price: 49.99,
      imageUrl: '💡',
      color: Colors.yellow.shade100,
    ),
    Product(
      id: '5',
      name: 'Water Bottle',
      description: 'Insulated stainless steel water bottle, keeps drinks cold for 24 hours',
      price: 34.99,
      imageUrl: '💧',
      color: Colors.blue.shade50,
    ),
    Product(
      id: '6',
      name: 'Backpack',
      description: 'Water-resistant backpack with laptop compartment and multiple pockets',
      price: 79.99,
      imageUrl: '🎒',
      color: Colors.brown.shade100,
    ),
    Product(
      id: '7',
      name: 'Phone Case',
      description: 'Protective phone case with drop protection and wireless charging support',
      price: 24.99,
      imageUrl: '📱',
      color: Colors.purple.shade100,
    ),
    Product(
      id: '8',
      name: 'Keyboard',
      description: 'Mechanical keyboard with RGB lighting and programmable keys',
      price: 129.99,
      imageUrl: '⌨️',
      color: Colors.grey.shade200,
    ),
  ];

  bool _isGridView = true;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverSafeArea - Ensures content stays within safe area
          const SliverSafeArea(
            sliver: SliverAppBar(
              // SliverAppBar - Collapsible app bar
              title: Text('Product Catalog'),
              floating: true,
              snap: true,
              actions: [
                Icon(Icons.search),
                SizedBox(width: 16),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isGridView) ...[
            // GridView.extent - Grid with maximum cross-axis extent
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: products.take(4).map((product) {
                    return Card(
                      // Card - Material design card
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.imageUrl,
                              style: const TextStyle(fontSize: 40),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // SliverGrid - Grid in custom scroll view
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = products[index];
                    return Card(
                      child: Stack(
                        // Stack - Widgets stacked on top of each other
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: product.color,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        product.imageUrl,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),
          ] else ...[
            // SliverList - List in custom scroll view
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: ListTile(
                      // ListTile - Standard list item with leading/trailing widgets
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: product.color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            product.imageUrl,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Buy',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle product tap
                      },
                    ),
                  );
                },
                childCount: products.length,
              ),
            ),
          ],
          // Additional GridView examples
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'More Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView(
                // ListView - Scrollable list
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: products.map((product) {
                  return Card(
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.imageUrl,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.name.split(' ').first,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // GridView.count - Grid with fixed number of columns
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: products.take(6).map((product) {
                  return Card(
                    color: product.color,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.imageUrl,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}