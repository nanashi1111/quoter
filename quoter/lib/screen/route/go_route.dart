import 'package:go_router/go_router.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/editor/editor_screen.dart';
import 'package:quoter/screen/home/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
        name: 'editor',
        path: '/editor:quote:backgroundPatternPos',
        builder: (context, state) {
          return EditorScreen(quote: Quote.fromJsonString(state.pathParameters['quote'] ?? ""), backgroundPatternPos: int.parse(state.pathParameters['backgroundPatternPos'] ?? ""),);
        })
  ],
);
