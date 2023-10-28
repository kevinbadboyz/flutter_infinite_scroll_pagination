import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_infinite_scroll_pagination_basic/cubit/post_pagination_cubit.dart';
import 'package:latihan_infinite_scroll_pagination_basic/ui/dashboard_page.dart';
import 'package:latihan_infinite_scroll_pagination_basic/ui/based_scroll_pagination_page.dart';
import 'package:latihan_infinite_scroll_pagination_basic/ui/post_pagination_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: HomePage(),
      home: DashboardPage(),
    );
  }
}

