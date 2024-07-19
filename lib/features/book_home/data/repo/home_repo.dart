import 'package:book_app/core/errors/failers.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:dartz/dartz.dart';


abstract class Home_repo{
  Future<Either<failers,List<Books>>>fetch_all_books();
  Future<Either<failers,List<Books>>>fetch_best_seller_books();
}