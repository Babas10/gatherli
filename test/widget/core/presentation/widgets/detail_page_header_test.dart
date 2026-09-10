// Validates DetailPageHeader renders its child inside a Card with the
// documented margin/padding, standardizing the container used by
// game/training/championship detail-page headers.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/core/presentation/widgets/detail_page_header.dart';

void main() {
  testWidgets('renders child inside a Card', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DetailPageHeader(child: Text('header content')),
      ),
    ));

    expect(find.byType(Card), findsOneWidget);
    expect(find.text('header content'), findsOneWidget);
  });

  testWidgets('uses the documented default margin', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DetailPageHeader(child: Text('content')),
      ),
    ));

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.margin, const EdgeInsets.fromLTRB(16, 12, 16, 4));
  });

  testWidgets('margin is overridable', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DetailPageHeader(
          margin: EdgeInsets.zero,
          child: Text('content'),
        ),
      ),
    ));

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.margin, EdgeInsets.zero);
  });
}
