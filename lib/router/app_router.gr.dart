// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<ListImage> listImage = const [],
    List<PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, listImage: listImage),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomePage(key: args.key, listImage: args.listImage);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.listImage = const []});

  final Key? key;

  final List<ListImage> listImage;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, listImage: $listImage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key &&
        const ListEquality<ListImage>().equals(listImage, other.listImage);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const ListEquality<ListImage>().hash(listImage);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    required Subscriptions profile,
    required List<ListImage> listImage,
    List<PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(
           key: key,
           profile: profile,
           listImage: listImage,
         ),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>();
      return ProfilePage(
        key: args.key,
        profile: args.profile,
        listImage: args.listImage,
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.profile,
    required this.listImage,
  });

  final Key? key;

  final Subscriptions profile;

  final List<ListImage> listImage;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, profile: $profile, listImage: $listImage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileRouteArgs) return false;
    return key == other.key &&
        profile == other.profile &&
        const ListEquality<ListImage>().equals(listImage, other.listImage);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      profile.hashCode ^
      const ListEquality<ListImage>().hash(listImage);
}

/// generated route for
/// [ServicePage]
class ServiseRoute extends PageRouteInfo<ServiseRouteArgs> {
  ServiseRoute({
    Key? key,
    required Subscriptions service,
    required List<ListImage> listImage,
    List<PageRouteInfo>? children,
  }) : super(
         ServiseRoute.name,
         args: ServiseRouteArgs(
           key: key,
           service: service,
           listImage: listImage,
         ),
         initialChildren: children,
       );

  static const String name = 'ServiseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiseRouteArgs>();
      return ServicePage(
        key: args.key,
        service: args.service,
        listImage: args.listImage,
      );
    },
  );
}

class ServiseRouteArgs {
  const ServiseRouteArgs({
    this.key,
    required this.service,
    required this.listImage,
  });

  final Key? key;

  final Subscriptions service;

  final List<ListImage> listImage;

  @override
  String toString() {
    return 'ServiseRouteArgs{key: $key, service: $service, listImage: $listImage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServiseRouteArgs) return false;
    return key == other.key &&
        service == other.service &&
        const ListEquality<ListImage>().equals(listImage, other.listImage);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      service.hashCode ^
      const ListEquality<ListImage>().hash(listImage);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    Key? key,
    required List<ListImage> listImage,
    List<PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, listImage: listImage),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>();
      return SignInPage(key: args.key, listImage: args.listImage);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, required this.listImage});

  final Key? key;

  final List<ListImage> listImage;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, listImage: $listImage}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignInRouteArgs) return false;
    return key == other.key &&
        const ListEquality<ListImage>().equals(listImage, other.listImage);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const ListEquality<ListImage>().hash(listImage);
}
