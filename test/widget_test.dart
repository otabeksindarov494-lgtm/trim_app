import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim_app/main.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/l10n/language_cubit.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final List<ListImage> imageList = [];
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LanguageCubit(),
        child: MyApp(imageList: imageList),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
