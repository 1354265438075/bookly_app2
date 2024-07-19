import 'package:book_app/core/book_service.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo_imp.dart';
import 'package:book_app/features/book_home/presentation/widgets/book_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Book_details_view extends StatefulWidget {
  Books book;
  Book_details_view(this.book);

  @override
  State<Book_details_view> createState() => _Book_details_viewState();
}

class _Book_details_viewState extends State<Book_details_view> {
  List<Books>? data;
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:18,right: 30),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.pink,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 18, left: 20),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            highlightColor: Colors.pink,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80,top:10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.5), // Shadow color
                      spreadRadius: 6, // Spread radius
                      blurRadius: 13, // Blur radius
                      offset:
                          Offset(0, 3), // Changes the position of the shadow
                    ),
                  ],
                ),

                child: Center(
                  child: ClipRRect(
                    child: widget.book.volumeInfo?.imageLinks?.thumbnail != null
                        ? Center(
                            child: Image.network(
                              widget.book.volumeInfo!.imageLinks!.thumbnail!,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 300,
                            ),
                          )
                        : Image.asset(
                            "assets/error.gif", // Fixed typo: "asssets" to "assets"
                            // Adjusted for consistency
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "${widget.book!.volumeInfo!.title}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  Center(
                      child: Text(
                    "${widget.book!.volumeInfo!.authors}",
                    style: TextStyle(color: Colors.white),
                  ))
                ],
              ),
            ),
            Container(
              width: 260,
              height: 100,
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5), // Shadow color
                            spreadRadius: 6, // Spread radius
                            blurRadius: 13, // Blur radius
                            offset:
                            Offset(0, 3), // Changes the position of the shadow
                          ),
                        ],
                        color: Colors.white,

                      ),
                      width: 130,
                      height: 50,
                      child: Center(

                          child: Row(
                            children: [
                              Text(
                                                      "     19.99",
                                                      style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                                                    ),
                              Icon(Icons.euro)
                            ],
                          ))),
                  Container(
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5), // Shadow color
                            spreadRadius: 6, // Spread radius
                            blurRadius: 13, // Blur radius
                            offset:
                            Offset(0, 3), // Changes the position of the shadow
                          ),
                        ],
                        color: Colors.pink,
                      ),
                      width: 130,
                      height: 50,
                      child: Center(
                          child: Text(
                            "Free Preview",
                            style: TextStyle(
                                color: Colors.white,

                                fontSize: 18),
                          ))),
                ],
              ),
            ),
            Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("You can also like",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    ],
                  ),
                ),

                SizedBox(
                  height: 150,

                  child: data != null
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Book_category(data![index]);
                    },
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            )
          ],

        ),
      ),
    );
  }
}
