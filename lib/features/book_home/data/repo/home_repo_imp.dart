import 'package:book_app/core/book_service.dart';
import 'package:book_app/core/errors/failers.dart';
import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:book_app/features/book_home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class Home_repo_imp implements Home_repo {
  final book_service service;

  Home_repo_imp(this.service);

  @override
  Future<Either<failers, List<Books>>> fetch_all_books() async {
    try {
      var data = await service.getdata(endpoint: "volumes?Filtering=free-ebooks&Sorting=newest%20&q=subject:");
      List<dynamic> items = data["items"] as List<dynamic>;
      List<Books> books = [];
      for (var item in items) {
        books.add(Books.fromJson(item));
      }
      return right(books);
    } catch (e) {
      return left(server_error(e.toString()));
    }
  }



  @override
  Future<Either<failers, List<Books>>> fetch_best_seller_books() async {
    try {
      var data = await service.getdata(endpoint: "volumes?Filtering=free-ebooks&Sorting=newest%20&q=subject:&Sorting=newest");
      List<dynamic> items = data["items"] as List<dynamic>;
      List<Books> books = [];
      for (var item in items) {
        books.add(Books.fromJson(item));
      }
      return right(books);
    } catch (e) {
      return left(server_error(e.toString()));
    }
  }
}

