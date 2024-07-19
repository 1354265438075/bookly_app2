import 'package:book_app/features/book_home/data/models/books.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class book_service{
  final base_url="https://www.googleapis.com/books/v1/";
  final Dio dio;

  book_service(this.dio);

  Future <Map<String,dynamic>> getdata({required String endpoint})async{
    var response=await dio.get("$base_url$endpoint");
    return response.data;

  }
}