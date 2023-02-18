import 'package:flutter/material.dart';
//import 'package:popup_card/styles.dart';

import 'hero_dialogue_route.dart';
import '../models.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
    required this.cardcolor,
    required this.popupcardcolor,
  });

  final Todo todo;
  final Color cardcolor;
  final Color popupcardcolor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: _TodoPopupCard(
                  todo: todo,
                  popupcardcolor: popupcardcolor,
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 8,
            right: 8,
          ),
          child: Hero(
            // createRectTween: (begin, end) {
            //   return CustomRectTween(begin: begin, end: end);
            // },
            tag: todo.id,
            child: Material(
              //color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(12),
              child: Placeholder(
                color: cardcolor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoPopupCard extends StatelessWidget {
  const _TodoPopupCard({
    required this.todo,
    required this.popupcardcolor,
  });
  final Todo todo;
  final Color popupcardcolor;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: todo.id,
      // createRectTween: (begin, end) {
      //   return CustomRectTween(begin: begin, end: end);
      // },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: popupcardcolor,
          child: const Padding(
            padding: EdgeInsets.all(30.0),
            child: Placeholder(),
          ),
        ),
      ),
    );
  }
}

class _TodoTitle extends StatelessWidget {
  /// {@macro todo_title}
  const _TodoTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
