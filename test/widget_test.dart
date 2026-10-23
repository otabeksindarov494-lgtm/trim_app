import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim_app/main.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/core/l10n/language_cubit.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final listImage = <ListImage>[];
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LanguageCubit(),
        child: MyApp(imageList: listImage),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
