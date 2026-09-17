import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  String id;
  String name;
  String category;
  int price;
  String description;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

List<Product> allProducts = [
  Product(
    id: '1',
    name: 'Газета Единство',
    category: 'Новости',
    price: 150,
    description: 'Главные новости и полезные объявления',
    imageUrl:
        'https://pr6.zoon.ru/YaHGVnIS3AnOYn-0mmUExA/600x789%2Cq85/zXa76LeiCI5RqFXURHsuQBzftQkwvg7hcRDj6l2XZctpY7_Su2OLDi8zOXQCbJj6UBImsAX9ikxESRqkkrzR4oz1f_k2H4f-fGs4Hh_DIVfC9JkmuszDta48kVQLXxkyVjhZlgKlHwH4Dn50ALpLus3MqD6TFa9oDoBKYBaCoxcTXO8WVFMAYZkIH6wNa5QKr8eMMV5WGbRN_ZfM8GIBisTeXeSGnlUXADi66x57P2JCDpI9lLlKUBFNySO9srUEbVnkhIW320uu2qfPLxFfw8rjGAPLB1QTmucs6u-XsyZZSX9kIOa4b2Tf9yvldlur',
  ),
  Product(
    id: '2',
    name: 'Челнинские известия',
    category: 'Новости',
    price: 200,
    description: 'Ваш надежный источник последних новостей',
    imageUrl:
        'https://avatars.mds.yandex.net/get-altay/5483320/2a0000017e4a636a61ddcf35a7ea0a12be9a/XXL_height',
  ),
  Product(
    id: '3',
    name: 'Наука и жизнь',
    category: 'Наука',
    price: 350,
    description: 'Все недавние научные открытия и история науки',
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/18124308/2a0000019b788a5b857862870724525f04d7/orig',
  ),
  Product(
    id: '4',
    name: 'Bazaar',
    category: 'Лайфстайл',
    price: 450,
    description: 'Модный женский журнал, новости моды и красоты',
    imageUrl:
        'https://files.mediiia.ru/projectimages/505/5ab1300fac1a4f8c8a269ae7f54bafe6/354eca8a237e4deebcd933780393c96a600x842.jpg',
  ),
  Product(
    id: '5',
    name: 'Мурзилка',
    category: 'Для детей и подростков',
    price: 650,
    description: 'Детская художественная литература',
    imageUrl:
        'https://basket-38.wbbasket.ru/vol8616/part861647/861647269/images/big/1.webp',
  ),
  Product(
    id: '6',
    name: 'Forbes Russia',
    category: 'Бизнес, финансы',
    price: 600,
    description:
        'Одно из наиболее авторитетных и известных финансово-экономических изданий в мире',
    imageUrl: 'https://file.sitepokupok.ru/good/100515533-123d38aa.jpg',
  ),
  Product(
    id: '7',
    name: 'Дружба народов',
    category: 'Литература',
    price: 750,
    description:
        'Издание, сохраняющее культурные связи и публикующее переводы из стран СНГ и дальнего рубежа',
    imageUrl:
        'https://basket-18.wbbasket.ru/vol2915/part291545/291545700/images/big/1.webp',
  ),
  Product(
    id: '8',
    name: 'Новый мир',
    category: 'Литература',
    price: 400,
    description: 'Журнал художественной литературы и общественной мысли',
    imageUrl:
        'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_678b0f0ffd59350cc9fde22e_678b0f17fd59350cc9fde333/scale_1200',
  ),
];

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

// Модель "Избранное"
class FavoritesModel {
  final List<Product> _items = [];
  List<Product> get items => _items;

  void toggle(Product product) {
    if (_items.contains(product)) {
      _items.remove(product);
    } else {
      _items.add(product);
    }
  }

  bool contains(Product product) => _items.contains(product);

  void remove(Product product) {
    _items.remove(product);
  }

  int get count => _items.length;
}

// Экземпляр модели "Избранное"
final FavoritesModel favorites = FavoritesModel();

class AutoScrollingCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final Duration scrollDuration;
  final Duration autoScrollInterval;

  const AutoScrollingCarousel({
    required this.items,
    this.height = 200,
    this.scrollDuration = const Duration(seconds: 1),
    this.autoScrollInterval = const Duration(seconds: 3),
    Key? key,
  }) : super(key: key);

  @override
  _AutoScrollingCarouselState createState() => _AutoScrollingCarouselState();
}

class _AutoScrollingCarouselState extends State<AutoScrollingCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _startAutoScroll() {
    Future.delayed(widget.autoScrollInterval, () {
      if (_pageController.hasClients) {
        final nextPage = _currentPage + 1;
        if (nextPage >= widget.items.length) {
          _pageController.animateToPage(
            0,
            duration: widget.scrollDuration,
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: widget.scrollDuration,
            curve: Curves.easeInOut,
          );
        }
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }

                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * widget.height,
                      child: Opacity(opacity: value, child: child),
                    ),
                  );
                },
                child: widget.items[index],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.blue
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин Газет и Журналов',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthWidget(),
    );
  }
}

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});
  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Вход в Ваш аккаунт", style: TextStyle(color: Colors.blue)),
        centerTitle: true,
      ),
      body: _HeaderWidget(),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 25), _FormWidget()],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String? errorText = null;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
      );
    } else {
      errorText = "Не верный логин или пароль";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16, color: Colors.black);
    final textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null)
          Text(
            "Не верный логин или пароль",
            style: TextStyle(color: Colors.red),
          ),
        Text("Имя пользователя", style: textStyle),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecorator,
        ),
        SizedBox(height: 5),
        Text("Пароль", style: textStyle),
        TextField(
          controller: _passwordTextController,
          decoration: textFieldDecorator,
          obscureText: true,
        ),
        SizedBox(height: 15),
        Row(
          children: [
            TextButton(
              onPressed: _auth,
              child: Text("Войти", style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 15, width: 15),
          ],
        ),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  List<CartItem> _cart = [];

  void _addToCart(Product product) {
    setState(() {
      int index = _cart.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        _cart[index].quantity++;
      } else {
        _cart.add(CartItem(product: product, quantity: 1));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} добавлен в корзину'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _removeFromCart(String productId) {
    setState(() {
      _cart.removeWhere((item) => item.product.id == productId);
    });
  }

  void _updateQuantity(String productId, int delta) {
    setState(() {
      int index = _cart.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        _cart[index].quantity += delta;
        if (_cart[index].quantity <= 0) {
          _cart.removeAt(index);
        }
      }
    });
  }

  int get _cartItemsCount {
    return _cart.fold(0, (sum, item) => sum + item.quantity);
  }

  int get _cartTotalPrice {
    return _cart.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void _updateFavorites() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Магазин Газет и Журналов'),
        actions: [
          // Иконка избранного
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.favorite),
                if (favorites.count > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${favorites.count}',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              ).then((_) => _updateFavorites());
            },
          ),
          // Иконка корзины
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              if (_cartItemsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$_cartItemsCount',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade700, Colors.blue.shade500],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 2),
                  Text(
                    'Магазин Газет и Журналов',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Последние новости и интересные журналы',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Товары'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Корзина'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Избранное'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                ).then((_) => _updateFavorites());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('О приложении'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('О приложении'),
                    content: Text(
                      'Магазин Газет и Журналов v1.0\nПриложение для покупки газет и журналов.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Закрыть'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Выйти'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => AuthWidget()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          CatalogPage(
            onAddToCart: _addToCart,
            onFavoritesChanged: _updateFavorites,
          ),
          CartPage(
            cart: _cart,
            onRemove: _removeFromCart,
            onQuantityChange: _updateQuantity,
            totalPrice: _cartTotalPrice,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Товары'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }
}

class CatalogPage extends StatefulWidget {
  final Function(Product) onAddToCart;
  final VoidCallback onFavoritesChanged;

  CatalogPage({required this.onAddToCart, required this.onFavoritesChanged});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  RangeValues _currentRangeValues = const RangeValues(0, 1000);
  var _filteredProducts = <Product>[];
  var _searchedProducts = <Product>[];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(allProducts);
    _searchedProducts = List.from(allProducts);
  }

  void _searchProducts() {
    final query = _searchController.text;
    if (query.isEmpty) {
      _searchedProducts = List.from(allProducts);
    } else {
      _searchedProducts = allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.category.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    _filterByPrice();
  }

  void _filterByPrice() {
    _filteredProducts = _searchedProducts.where((product) {
      return product.price >= _currentRangeValues.start &&
          product.price <= _currentRangeValues.end;
    }).toList();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Карусель
        AutoScrollingCarousel(
          items: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red.shade400, Colors.red.shade700],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.newspaper, size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Свежие новости!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Новые поступления каждый день',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade400, Colors.green.shade700],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.discount, size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Скидки до 50%!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'На популярные журналы',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_stories, size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Читайте с удовольствием!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Лучшие издания для вас',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
          height: 180,
        ),
        SizedBox(height: 8),
        // Поиск
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск товаров...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _searchProducts();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) {
              _searchProducts();
            },
          ),
        ),
        // RangeSlider для фильтрации по цене
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 1000,
                divisions: 10,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                    _filterByPrice();
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Цена: от ${_currentRangeValues.start.round()} до ${_currentRangeValues.end.round()} руб.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        // Список товаров
        Expanded(
          child: _filteredProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Ничего не найдено',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, error, stack) =>
                                          Container(
                                            color: Colors.grey.shade300,
                                            child: Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                  // Иконка избранного
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          favorites.contains(product)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            favorites.toggle(product);
                                            widget.onFavoritesChanged();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${product.price} руб.',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          widget.onAddToCart(product),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(
                                        'В корзину',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// Страница детального описания продукта
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(
              favorites.contains(widget.product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                favorites.toggle(widget.product);
              });
            },
          ),
          IconButton(icon: Icon(Icons.share), onPressed: _shareProduct),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: PageView(
                children: [
                  Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, error, stack) => Container(
                      color: Colors.grey.shade300,
                      child: Center(child: Icon(Icons.broken_image, size: 50)),
                    ),
                  ),
                ],
              ),
            ),

            // Индикатор страниц для галереи
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Категория: ${widget.product.category}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  SizedBox(height: 8),

                  Text(
                    '${widget.product.price} руб.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Описание:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    widget.product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: 24),

                  // Счетчик количества
                  Row(
                    children: [
                      Text('Количество:', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 16),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                      ),
                      Text('$_quantity', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Кнопка добавления в корзину
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Товар добавлен в корзину'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        'Добавить в корзину',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Функция "Поделиться" будет реализована позже')),
    );
  }
}

// Страница избранного
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: favorites.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Нет избранных товаров',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.items.length,
              itemBuilder: (context, index) {
                final product = favorites.items[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stack) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text('${product.price} руб.'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favorites.toggle(product);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritesPage(),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<CartItem> cart;
  final Function(String) onRemove;
  final Function(String, int) onQuantityChange;
  final int totalPrice;

  CartPage({
    required this.cart,
    required this.onRemove,
    required this.onQuantityChange,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Корзина пуста',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Добавьте товары из каталога',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (ctx, index) {
              final item = cart[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.product.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stack) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  title: Text(
                    item.product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${item.product.price} руб. x ${item.quantity} = ${item.product.price * item.quantity} руб.',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () => onQuantityChange(item.product.id, -1),
                      ),
                      Container(
                        width: 30,
                        child: Text(
                          '${item.quantity}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () => onQuantityChange(item.product.id, 1),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => onRemove(item.product.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey.shade200)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Итого:',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    '$totalPrice руб.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Заказ оформлен'),
                      content: Text(
                        'Спасибо за покупку! Сумма заказа: $totalPrice руб.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.check_circle),
                label: Text('Оформить заказ'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
