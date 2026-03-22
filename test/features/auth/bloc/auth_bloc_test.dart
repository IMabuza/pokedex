import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';
import 'package:pokedex/features/auth/models/user.dart';
import 'package:pokedex/features/auth/services/auth_service.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthService = MockAuthService();
    authBloc = AuthBloc((mockAuthService));
  });

  tearDown(() {
    authBloc.close();
  });
  group("AuthBloc", () {
    test("AuthIntial should be intial state", () {
      expect(authBloc.state, isA<AuthInitial>());
    });

    group("Register", () {
      blocTest<AuthBloc, AuthState>(
        "emits [AuthLoading, AuthSuccess] when register is successful",
        setUp: () {
          when(() => mockAuthService.register(any(), any())).thenAnswer(
            (_) async =>
                AuthUser(email: "test@example.com", uid: "shhjshjhjshj"),
          );
        },
        build: () => authBloc,
        act: (bloc) =>
            bloc.add(Register("test@example.com", "8888888888", "8888888888")),
        expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
      );

      blocTest<AuthBloc, AuthState>(
        "emits [AuthLoading, AuthError] when register fails",
        setUp: () {
          when(
            () => mockAuthService.register(any(), any()),
          ).thenThrow((_) async => Exception("Failed to register"));
        },
        build: () => authBloc,
        act: (bloc) =>
            bloc.add(Register("test@example.com", "8888888888", "8888888888")),
        expect: () => [isA<AuthLoading>(), isA<AuthError>()],
      );
    });

    group("Sign In", () {
      blocTest<AuthBloc, AuthState>(
        "emits [AuthLoading, AuthSuccess] when sign in is successful",
        setUp: () {
          when(() => mockAuthService.signIn(any(), any())).thenAnswer(
            (_) async =>
                AuthUser(email: "test@example.com", uid: "shhjshjhjshj"),
          );
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(SignIn("test@example.com", "8888888888")),
        expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
      );

      blocTest<AuthBloc, AuthState>(
        "emits [AuthLoading, AuthError] when sign in fails",
        setUp: () {
          when(
            () => mockAuthService.signIn(any(), any()),
          ).thenThrow((_) async => Exception("Failed to sign in"));
        },
        build: () => authBloc,
        act: (bloc) =>
            bloc.add(SignIn("test@example.com", "8888888888")),
        expect: () => [isA<AuthLoading>(), isA<AuthError>()],
      );
    });
  });
}
