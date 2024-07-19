import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:flutter/material.dart';
class Book_category extends StatelessWidget {
  @override
  Books book;
  Widget build(BuildContext context) {
   return
         Padding(
           padding: const EdgeInsets.only(top:30,left: 13),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10),
             child: book.volumeInfo?.imageLinks?.thumbnail!= null
                 ? Image.network(
               book.volumeInfo!.imageLinks!.thumbnail!,
               fit: BoxFit.cover,
               width: 120,
               height: 300,
             )
                 : Image.asset(
               "assets/error.gif", // Fixed typo: "asssets" to "assets"
               // Adjusted for consistency
               fit: BoxFit.cover, // Adjust the fit as needed
             ),
           ),
         );




  }

  Book_category(this.book);
}
