import 'package:flutter/material.dart';
import 'popup_card.dart';
import 'models.dart';

class CategoryListView extends StatelessWidget {
  final int index;

  const CategoryListView({
    super.key,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (index == 0) ...[
        const TodoCard(todo: Todo(id: "Hi", description: "test")),
      ] else if (index == 1) ...[
        SizedBox(
          height: 190,
          child: ListView(
            children: const [
              Placeholder(
                color: Colors.blue,
              ),
              Placeholder(
                color: Colors.blue,
              ),
              Placeholder(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ] else ...[
        SizedBox(
          height: 190,
          child: ListView(
            children: const [
              Placeholder(
                color: Colors.green,
              ),
              Placeholder(
                color: Colors.green,
              ),
              Placeholder(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ]
    ]);
  }
}
