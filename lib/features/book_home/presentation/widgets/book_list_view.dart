
import 'package:book_app/core/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/views/Book_details_view.dart';
import 'package:book_app/features/book_home/presentation/widgets/book_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class Book_list_view extends StatefulWidget {
  @override
  State<Book_list_view> createState() => _Book_list_viewState();
}

class _Book_list_viewState extends State<Book_list_view> {
  List<Books> data=[];

  @override
  void initState(){
    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {
    try {
      // Initialize Dio instance for book_service
      Dio dio = Dio(); // You can customize Dio with options as needed
      var result = await Home_repo_imp(book_service(dio)).fetch_all_books();

      result.fold(
            (failure) {
          // Handle failure case
          print('Failed to fetch data: $failure');
          setState(() {
            // Optionally, handle error state or show a message
            data = []; // Set data to empty list or handle error condition
          });
        },
            (booksList) {
          // Handle success case
          setState(() {
            data = booksList;
          });
        },
      );
    } catch (e) {
      // Handle exceptions, e.g., Dio errors or other unexpected errors
      print('Error fetching data: $e');
      setState(() {
        data = []; // Set data to empty list or handle error condition
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return SliverList(delegate: SliverChildBuilderDelegate((context,index){
      return InkWell(child: Book_tile(data[index]),onTap: (){
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => Book_details_view(
      data![index],
      // selectedIndex: index,
      ),
      ),
      );
      });



    },childCount: data.length));
  }
}
