
import 'package:book_app/features/book_home/presentation/widgets/book_category_list.dart';
import 'package:book_app/features/book_home/presentation/widgets/book_list_view.dart';
import 'package:flutter/material.dart';
class BookHomeView extends StatefulWidget {
  const BookHomeView({super.key});

  @override
  _BookHomeViewState createState() => _BookHomeViewState();
}

class _BookHomeViewState extends State<BookHomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation

    // Create a double animation from 0 to 1
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shadowColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
        title: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: "B o o k l y".split('').map((letter) {
                return Transform(
                  transform: Matrix4.rotationY(_animation.value * 3.14), // Rotate 180 degrees
                  alignment: Alignment.center,
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Book_category_list()),
          Book_list_view(),
        ],
      ),
    );
  }
}

// Dummy placeholder widgets
class BookCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 100, color: Colors.grey);
  }
}

class BookListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
          title: Text("Book $index", style: TextStyle(color: Colors.white)),
        ),
        childCount: 20,
      ),
    );
  }
}