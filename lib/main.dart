import 'dart:async';
import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/user_info_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/providers/notification_provider.dart';
import 'package:app_well_mate/screen/home.dart';
import 'package:app_well_mate/screen/login.dart';
import 'package:app_well_mate/screen/medication.dart';
import 'package:app_well_mate/screen/profile.dart';
import 'package:app_well_mate/screen/scan.dart';
import 'package:app_well_mate/screen/search.dart';
import 'package:app_well_mate/screen/theme.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF6B94FF),
    onPrimary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFA8C5FD),
    onSecondary: const Color(0xFF000000),
    error: AppColor.red,
    onError: const Color(0xFF000000),
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF000000),
    surfaceDim: const Color(0xFFF2F2F2),
    errorContainer: const Color(0xFFFFF4F4));

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CartPageProvider(),
    ),
    ChangeNotifierProvider(create: (context) {
      return NotificationProvider();
    })
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  StreamSubscription<List<ConnectivityResult>>? subscription;
  Future<void> getUserAndToken() async {}
  Future<void>? future;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartPageProvider>(context, listen: false).fetchDrugCart();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
            badgeTheme: BadgeThemeData(
                textColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 6)),
            colorScheme: colorScheme,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                      GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  backgroundColor: WidgetStateProperty.resolveWith((e) {
                    if (e.contains(WidgetState.disabled)) {
                      return AppColor.gray;
                    }
                    return colorScheme.primary;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((e) {
                    if (e.contains(WidgetState.disabled)) {
                      return AppColor.darkerGray;
                    }
                    return colorScheme.onPrimary;
                  }),
                  shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
                  minimumSize: WidgetStateProperty.all(const Size(40, 50)),
                  elevation: WidgetStateProperty.resolveWith((state) {
                    if (state.contains(WidgetState.pressed)) {
                      return 5;
                    }
                    return 0;
                  })),
            ),
            snackBarTheme: SnackBarThemeData(
                backgroundColor: colorScheme.primary,
                contentTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: colorScheme.onPrimary),
                insetPadding: const EdgeInsets.all(40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                )),
            dividerTheme: const DividerThemeData(
              color: AppColors.greyColor,
              thickness: 1,
            ),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    padding:
                        WidgetStateProperty.all(const EdgeInsets.all(16)))),
            filledButtonTheme: FilledButtonThemeData(
                style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                  GoogleFonts.inter(fontWeight: FontWeight.bold)),
              backgroundColor: WidgetStateProperty.all(colorScheme.surfaceDim),
              foregroundColor: WidgetStateProperty.all(colorScheme.onSurface),
              minimumSize: WidgetStateProperty.all(const Size(40, 50)),
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
            )),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
              minimumSize: WidgetStateProperty.all(const Size(40, 50)),
            )),
            textTheme: TextTheme(
                bodyLarge: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0),
                bodyMedium: GoogleFonts.inter(fontSize: 16),
                bodySmall: GoogleFonts.inter(fontSize: 12),
                displayLarge: GoogleFonts.inter(
                    fontSize: 54, fontWeight: FontWeight.bold),
                displayMedium: GoogleFonts.inter(
                    fontSize: 46, fontWeight: FontWeight.bold),
                displaySmall: GoogleFonts.inter(
                    fontSize: 30, fontWeight: FontWeight.bold),
                headlineLarge: GoogleFonts.inter(
                    fontSize: 28, fontWeight: FontWeight.bold),
                headlineMedium: GoogleFonts.inter(
                  fontSize: 24,
                ),
                headlineSmall: GoogleFonts.inter(
                  fontSize: 20,
                ),
                labelLarge: GoogleFonts.inter(fontSize: 16),
                labelMedium: GoogleFonts.inter(fontSize: 14),
                labelSmall: GoogleFonts.inter(fontSize: 12),
                titleLarge: GoogleFonts.inter(fontWeight: FontWeight.bold),
                titleMedium: GoogleFonts.inter(fontWeight: FontWeight.bold),
                titleSmall: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.onSurface,
                elevation: 5,
                iconSize: 32,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)))),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedIconTheme:
                    IconThemeData(color: colorScheme.onSurface),
                selectedIconTheme: IconThemeData(color: colorScheme.primary),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed),
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (context) => const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              ),
            ),
            popupMenuTheme: const PopupMenuThemeData(
                elevation: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            dropdownMenuTheme: DropdownMenuThemeData(
                textStyle: Theme.of(context).textTheme.bodyMedium,
                menuStyle: MenuStyle(
                  shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
                )),
            iconTheme: IconThemeData(
                color: colorScheme.onSurface, fill: 0, weight: 600),
            appBarTheme: const AppBarTheme(
                scrolledUnderElevation: 0, titleSpacing: 20, toolbarHeight: 75),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily:
                        GoogleFonts.inter(wordSpacing: 0, color: AppColor.gray).fontFamily,
                    color: AppColor.darkerGray),
                border: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.darkerGray)))),
        debugShowCheckedModeBanner: false,
        home: const Login());
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedPage = 0;
  Future<InfoUserModel?>? userData;
  final List<Widget> _pages = [
    const Home(),
    const SearchPage(),
    const ScanPage(),
    const MedicationPage(),
    const ThemeScreen()
  ];
  initNotification() {
    // void _onTap(index) {
    //   setState(() {
    //     _selectedPage = index;
    //   });
    // }
  }

  @override
  void initState() {
    userData = ApiRepo().getInfoUser();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      Provider.of<NotificationProvider>(context, listen: false)
          .requestPermission(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Symbols.home_rounded), label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Icon(Symbols.search_rounded), label: "Tìm kiếm"),
            BottomNavigationBarItem(
              icon: Icon(Symbols.camera_alt_rounded),
              label: "Quét QR",
            ),
            BottomNavigationBarItem(
                icon: Icon(Symbols.pill), label: "Lịch uống thuốc"),
            BottomNavigationBarItem(
                icon: Icon(Symbols.face_6), label: "Cài đặt"),
            // BottomNavigationBarItem(
            //     icon: Icon(Symbols.brush), label: "debug"),
          ],
          currentIndex: _selectedPage,
          onTap: _onTap,
        ),
        body: Center(
          child: _selectedPage == 4
              ? FutureBuilder<InfoUserModel?>(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Thongtincanhan();
                    } else {
                      return const Text('No user data available');
                    }
                  },
                )
              : _pages[_selectedPage],
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
        // body: Center(

        //   child: _pages[_selectedPage],
        // ),
        
//       ),
//     );
//   }
// }
