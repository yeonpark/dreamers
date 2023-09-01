import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/features/account/screens/update_profile_screen.dart';
import 'package:dreamers/features/account/screens/profile_screen.dart';
import 'package:dreamers/features/auth/screens/login_screen.dart';
import 'package:dreamers/features/auth/screens/register_screen.dart';
import 'package:dreamers/features/home/screens/item_list_screen.dart';
import 'package:dreamers/features/notification/screens/notification_screen.dart';
import 'package:dreamers/features/story/screens/post_payment_screen.dart';
import 'package:dreamers/features/story/screens/story_detail.dart';
import 'package:dreamers/models/story.dart';
import 'package:dreamers/features/story/screens/post_story_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case AuthScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AuthScreen(),
    //   );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case ItemList.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ItemList(),
      );
    case ItemPage.routeName:
      var story = routeSettings.arguments as Story;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ItemPage(story: story),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationScreen(),
      );
    case PostStoryScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PostStoryScreen(),
      );
    case ThankYouPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ThankYouPage(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterScreen(),
      );
    case UpdateProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UpdateProfileScreen(),
      );
    case AccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountScreen(),
      );

    //
    // case CategoryDealsScreen.routeName:
    //   var category = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => CategoryDealsScreen(
    //       category: category,
    //     ),
    //   );
    // case SearchScreen.routeName:
    //   var searchQuery = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchScreen(
    //       searchQuery: searchQuery,
    //     ),
    //   );
    // case ProductDetailScreen.routeName:
    //   var product = routeSettings.arguments as Product;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ProductDetailScreen(
    //       product: product,
    //     ),
    //   );
    // case AddressScreen.routeName:
    //   var totalAmount = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => AddressScreen(
    //       totalAmount: totalAmount,
    //     ),
    //   );
    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as Order;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
