import 'package:flutter/material.dart';
import 'package:latihan_infinite_scroll_pagination_basic/ui/based_scroll_pagination_page.dart';
import 'package:latihan_infinite_scroll_pagination_basic/ui/post_pagination_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Scroll Pagination'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BasedScrollPaginationPage()));
            },
            title: Text('Based Scroll Pagination'),
            subtitle: Text('With Package Infinite Scroll Pagination'),
          ),
          Divider(thickness: 1.0,),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PostPagination()));
            },
            title: Text('Scroll Pagination with Cubit'),
            subtitle: Text('Scroll Pagination'),
          ),
          Divider(thickness: 1.0,),
        ],
      ),
    );
  }
}
