import 'package:go_router/go_router.dart';
import 'package:quoter/models/category_of_quote.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/categories/category_screen.dart';
import 'package:quoter/screen/category_detail/category_detail_screen.dart';
import 'package:quoter/screen/editor/editor_screen.dart';
import 'package:quoter/screen/go_premium/go_premium_screen.dart';
import 'package:quoter/screen/home/home_screen.dart';
import 'package:quoter/screen/menu/menu_screen.dart';
import 'package:quoter/screen/my_quotes/my_quotes_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return MenuScreen();
      },
    ),
    GoRoute(
      path: '/category_detail',
      builder: (context, state) {
        CategoryOfQuote category = state.extra as CategoryOfQuote;
        return CategoryDetailScreen(
          category: category,
        );
      },
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) {
        return const CategoryScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
        name: 'editor',
        path: '/editor:quote:backgroundPatternPos',
        builder: (context, state) {
          return EditorScreen(
            quote: Quote.fromJsonString(state.pathParameters['quote'] ?? ""),
            backgroundPatternPos: int.parse(state.pathParameters['backgroundPatternPos'] ?? ""),
          );
        }),
    GoRoute(
        name: 'go_premium',
        path: '/go_premium',
        builder: (context, state) {
          return const GoPremiumScreen();
        }),
    GoRoute(
        name: 'my_quotes',
        path: '/my_quotes',
        builder: (context, state) {
          return const MyQuotesScreen();
        })
  ],
);
