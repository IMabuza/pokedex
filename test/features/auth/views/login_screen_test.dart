import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/widgets/primary_button.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';
import 'package:pokedex/features/auth/services/auth_service.dart';
import 'package:pokedex/features/auth/views/login_screen.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });
  group("Login Screen Widget Tests", () {
    testWidgets("displays email and password input fields", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AuthBloc(mockAuthService),
            child: const LoginScreen(),
          ),
        ),
      );
      expect(find.byType(TextFormField, ), findsNWidgets(2));
    });

     testWidgets("displays login button", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AuthBloc(mockAuthService),
            child: const LoginScreen(),
          ),
        ),
      );
      expect(find.byType(PrimaryButton, ), findsOneWidget);
    });

      testWidgets("Email field is interactive", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => AuthBloc(mockAuthService),
            child: const LoginScreen(),
          ),
        ),
      );
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, "email@email.com");
      expect(find.text("email@email.com"), findsOneWidget);
    });
  });
}
