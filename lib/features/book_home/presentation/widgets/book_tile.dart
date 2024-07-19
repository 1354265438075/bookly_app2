import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:flutter/material.dart';
class Book_tile extends StatelessWidget {
  final Books book;

  Book_tile(this.book);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Padding(
          padding: const EdgeInsets.only(left:30,top:30,right:20),
          child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 3), // Changes the position of the shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: book.volumeInfo?.imageLinks?.smallThumbnail != null
                  ? Image.network(
                book.volumeInfo!.imageLinks!.smallThumbnail!,
                height: 130,
                width: 80,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                "assets/error.gif", // Fixed typo: "asssets" to "assets"
                width: 120, // Adjusted for consistency
                height: 150, // Adjusted for consistency
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          )
        )
,SizedBox(width: 10,)
        ,

           Padding(
             padding: const EdgeInsets.only(top:33),
             child: Container(

              width: 200,
              height: 130,
              child: Column(
               children: [
                 Center(
                   child:

                   Text(
                     "${book.volumeInfo?.title!=null?book.volumeInfo!.title!:"empty..."}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                     color: Colors.white,
                     fontSize: 18,
                     fontWeight: FontWeight.w500,

                   ),
                   ),
                 ),

                 Center(
                   child: Text("${book.volumeInfo?.authors!=null?book.volumeInfo?.authors!:"empty..."}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                     color: Colors.grey,
                     fontSize: 15,
                     fontWeight: FontWeight.w500,

                   ),
                   ),
                 ),
                 Row(
                   children: [
                     Text("19.99",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold,fontSize:18),),
                     Icon(Icons.euro,color: Colors.pink,),
                     SizedBox(width: 26),
                     Icon(Icons.star,color: Colors.yellow,),
                     Text("4.8 (2390)",style: TextStyle(color: Colors.white))
                   ],
                 )
               ],
              ),
                       ),
           ),






      ],
    );
  }
}
