// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/city_provider.dart';
import 'package:project/Providers/order_product_provider.dart';
import 'package:project/Providers/order_provider.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/firebase_options.dart';
import 'package:project/models/category_model.dart';
import 'package:project/models/product_model.dart';
import 'package:project/views/Admin/dash_board.dart';
import 'package:project/views/Login/forget_password.dart';
import 'package:project/views/Login/verification_page.dart';
import 'package:project/views/cart_page.dart';
// import 'package:project/views/category_page.dart';
import 'package:project/views/fliter.dart';
import 'package:project/views/Login/login_page.dart';
import 'package:project/views/my_order_page.dart';
import 'package:project/views/order_detail.dart';
import 'package:project/views/profile_page.dart';
import 'package:project/views/profile_page_basic.dart';
import 'package:project/views/reset_password_page.dart';
import 'package:project/views/shopping_cart_icon.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProductProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'),
        ],
        title: 'Flutter Demo',
        builder: EasyLoading.init(), // Initialize EasyLoading

        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFffffff)),
        initialRoute: "/logoPage",
        onGenerateRoute: (settings) {
          var routes = {
            "/": (context) => const BottomNavigation(),
            "/loginPage": (context) => const LoginPage(),
            "/profilePage": (context) => ProfilePage(
                  onBack: () {},
                ),
            "/myhomepage": (context) => const MyHomePage(),
            "/bottomnavigation": (context) => const BottomNavigation(),
            //"/categoryPage": (context) => const CategoriesPage(),
            "/cartPage": (context) => const CartPage(),
            "/fliterPage": (context) => FliterPage(
                  onBack: () {},
                ),
            "/myOrderPage": (context) => const MyOrederPage(),
            "/orderdetail": (context) => OrderDetailPage(
                  onBack: () {},
                ),
            "/profilepagebisic": (context) => const ProfilePageBasic(),
            "/forgetPassword": (context) => ForgetPasswordPage(
                  onBack: () {},
                ),
            "/verificationPage": (context) => const VerificationPage(),
            "/resetPasswordPage": (context) => RestPasswordPage(
                  onBack: () {},
                ),
            "/logoPage": (context) => const LogoPage(),
            "/dashBoard": (context) => const DashBoard(),
            "/bottomNavigationAdmin": (context) =>
                const BottomNavigationAdmin(),
            // "/splashScreen2": (context) => const SplashScreen2(),
          };
          WidgetBuilder builder = routes[settings.name]!;
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    );
  }
}

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      checkType();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFffffff),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }

  int? typeId;
  Future<void> checkType() async {
    // await FlutterSecureStorage().deleteAll();
    if (await const FlutterSecureStorage().containsKey(key: 'typeId')) {
      String? type = await FlutterSecureStorage().read(key: 'typeId');

      if (int.parse(type!) == 2) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const BottomNavigationAdmin()),
          (Route<dynamic> route) => false,
        );
      }
    } else
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
        (Route<dynamic> route) => false,
      );
  }
}

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List pages = [
    const MyHomePage(),
    //const CategoriesPage(),
    const CartPage(),
    const MyOrederPage(),
    const SplashScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
      _currentPage = pages[currentIndex];
    });
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _connectedToInternet = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() {
          _connectedToInternet = result != ConnectivityResult.none;
        });
      },
    );
    _currentPage = pages[currentIndex];
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectedToInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  Widget? _currentPage;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;
    setState(() {
      _currentPage ??= pages[currentIndex];
    });
    return WillPopScope(
      onWillPop: () async {
        final differnce = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differnce >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = "انقر مرتين للخروج";
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
          appBar: productProvider.hideAppBar
              ? null
              : AppBar(
                  backgroundColor: Colors.blue[700],
                  toolbarHeight: 47,
                  actions: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          setState(
                            () {
                              productProvider.hideAppBar = true;
                              productProvider.hideNavigationBar = true;
                              _currentPage = FliterPage(
                                onBack: () {
                                  setState(() {
                                    _currentPage = pages[currentIndex];
                                  });
                                },
                              );
                            },
                          );
                          products.clear();
                        },
                      ),
                    ),
                  ],
                  title: Row(
                    children: [
                      SizedBox(
                        width: 149,
                        child: Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .name
                                .isNotEmpty
                            ? Text(
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .name,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              )
                            : Container(),
                      ),
                      Center(
                        child: SizedBox(
                          width: 150,
                          // height: 150,
                          child: Image.asset(
                            'assets/images/logoAppBar.png',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          body: _connectedToInternet
              ? _currentPage
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cloud_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      Text(
                        'لا يوجد اتصال بالإنترنت',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: productProvider.hideNavigationBar
              ? null
              : BottomNavigationBar(
                  unselectedLabelStyle:
                      const TextStyle(fontSize: 15, color: Colors.black),
                  selectedLabelStyle:
                      TextStyle(fontSize: 15, color: Colors.blue[700]),
                  showUnselectedLabels: true,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.blue[700],
                  type: BottomNavigationBarType.fixed,
                  //type: BottomNavigationBarType.shifting,طريقة الكبسة
                  onTap: onTap,
                  currentIndex: currentIndex,
                  // elevation: 0,الخط الفوق
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "الرئيسة",
                    ),
                    BottomNavigationBarItem(
                      icon: ShoppingCartIcon(),
                      label: "السلة",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      label: "طلباتي",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_rounded,
                      ),
                      label: "حسابي",
                    ),
                  ],
                )),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _currentPage = Container();
  bool isLoading = true;
  bool exists = false;
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() async {
    exists = await const FlutterSecureStorage().containsKey(key: "typeId");
    setState(() {
      if (exists) {
        _currentPage = const ProfilePageBasic();
      } else {
        _currentPage = const LoginPage();
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: BackGroundImage());
    } else {
      return Scaffold(
        body: _currentPage,
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentPage = const MyHomePage();
  final List<String> imageUrls = [
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/1.png',
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/21.png',
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/12.png',
  ];
  final List<String> imageUrls2 = [
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/2.png',
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/11.png',
    'https://mahmoud1.fra1.digitaloceanspaces.com/home/22.png',
  ];
  PageController? _pageController;
  PageController? _pageController2;
  int _currentPageIndex = 0;
  int _currentPageIndex2 = 0;
  String? name;
  Timer? _timer;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController = PageController(
        initialPage: imageUrls.length * 1000,
      )..addListener(_pageListener);
      _pageController2 = PageController(
        initialPage: imageUrls2.length * 1000,
      )..addListener(_pageListener2);
    });
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      var nextPageIndex = _currentPageIndex + 1;
      var nextPageIndex2 = _currentPageIndex2 + 1;

      if (nextPageIndex >= imageUrls.length) {
        nextPageIndex = 0;
        _pageController!.animateToPage(
          nextPageIndex,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController!.animateToPage(
          nextPageIndex,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      }

      if (nextPageIndex2 >= imageUrls2.length) {
        nextPageIndex2 = 0;
        _pageController2!.animateToPage(
          nextPageIndex2,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController2!.animateToPage(
          nextPageIndex2,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showName();
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    provider.getAllCategory();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getAllProductsByCategoryID();
  }

  void _pageListener() {
    setState(() {
      _currentPageIndex = _pageController!.page!.round() % imageUrls.length;
    });
  }

  void _pageListener2() {
    setState(() {
      _currentPageIndex2 = _pageController2!.page!.round() % imageUrls2.length;
    });
  }

  Future<void> showName() async {
    if (_isDisposed) return;

    if (await const FlutterSecureStorage().containsKey(key: 'typeId')) {
      String? fistName = await FlutterSecureStorage().read(key: 'fistName');
      String? gender = await FlutterSecureStorage().read(key: 'genderId');
      if (int.parse(gender!) == 1) {
        name = "اهلا السيد $fistName";
      } else if (int.parse(gender) == 2) {
        name = "اهلا السيدة $fistName";
      }

      if (!_isDisposed) {
        setState(() {
          final provider =
              Provider.of<CategoryProvider>(context, listen: false);
          provider.name = name!;
        });
      }
    }
  }

  // bool hideAppBar = false;
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final category = categoryProvider.categories;
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                _currentPage is MyHomePage
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 10),
                              child: Row(
                                children: const [
                                  Text(
                                    "وصل حديثا",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 200,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: imageUrls.length * 10000,
                                itemBuilder: (BuildContext context, int index) {
                                  final int imageIndex =
                                      index % imageUrls.length;
                                  return InteractiveViewer(
                                    minScale: 0.1,
                                    maxScale: 5.0,
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrls[imageIndex],
                                      placeholder: (context, url) =>
                                          const Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 10),
                              child: Row(
                                children: const [
                                  Text(
                                    "قريبا",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: PageView.builder(
                                controller: _pageController2,
                                itemCount: imageUrls2.length * 10000,
                                itemBuilder: (BuildContext context, int index) {
                                  final int imageIndex =
                                      index % imageUrls2.length;
                                  return InteractiveViewer(
                                    minScale: 0.1,
                                    maxScale: 5.0,
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrls2[imageIndex],
                                      placeholder: (context, url) =>
                                          const Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 10),
                              child: Row(
                                children: const [
                                  Text(
                                    "الأقسام",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              // height: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.length,
                                    itemBuilder: (context, index) {
                                      CategoryModel categories =
                                          category[index];
                                      return Consumer(
                                        builder: (context,
                                            ProductProvider productProvider,
                                            child) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productProvider.id =
                                                    categories.id!;
                                                productProvider
                                                    .getAllProductsByCategoryID();
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: productProvider
                                                                        .id ==
                                                                    categories
                                                                        .id
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        categories.category,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: productProvider
                                                                      .id ==
                                                                  categories.id
                                                              ? Colors.black
                                                              : Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 540,
                              child: products.isEmpty
                                  ? const Center(
                                      child: SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: CircularProgressIndicator(),
                                    ))
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.65,
                                      ),
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        ProductModel product = products[index];

                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .black26)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 10,
                                                          right: 10),
                                                  child: Wrap(
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        height: 100,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              product.image,
                                                          placeholder:
                                                              (context, url) =>
                                                                  const Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: SizedBox(
                                                              width: 70,
                                                              height: 70,
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                            Icons.error,
                                                            size: 50,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: const [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 70,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          product.name,
                                                          maxLines: 2,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: const [
                                                          SizedBox(
                                                            height: 35,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: Text(
                                                              "${product.price.toStringAsFixed(2)} د.أ",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    // borderRadius:
                                                                    //     BorderRadius.circular(40),
                                                                    ),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              onPressed: () {
                                                                productProvider
                                                                    .addToCart(
                                                                        product);
                                                                EasyLoading
                                                                    .dismiss();
                                                                EasyLoading
                                                                    .showSuccess(
                                                                        "تم الاضافة الى السلة");
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .add_shopping_cart,
                                                                size: 30,
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                      )
                    : FliterPage(
                        onBack: () {
                          setState(() {
                            _currentPage = const MyHomePage();
                          });
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
