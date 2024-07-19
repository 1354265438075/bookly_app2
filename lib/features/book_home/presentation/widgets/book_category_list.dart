
import 'package:book_app/core/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/views/Book_details_view.dart';
import 'package:book_app/features/book_home/presentation/widgets/book_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Book_category_list extends StatefulWidget {
  const Book_category_list({super.key});

  @override
  State<Book_category_list> createState() => _Book_category_listState();
}

class _Book_category_listState extends State<Book_category_list> {
  List<Books>? data;
  int selectedIndex = -1; // Initialize selectedIndex to -1
  late final book_service service;
  @override
  void initState() {
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
    if (data == null) {
      // Display a loading indicator while data is being fetched
      return Column(
        children: [
          SizedBox(height: 200),
          const CircularProgressIndicator(
            color: Colors.pink,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 210, // Set a fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Make the scrolling direction horizontal
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Navigate to the details screen and pass the selected book index
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Book_details_view(
                         data![index],
                       // selectedIndex: index,
                      ),
                    ),
                  );
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Book_category(data![index]),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "Best Seller",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
