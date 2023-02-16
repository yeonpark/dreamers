import 'package:flutter/material.dart';
//import 'package:popup_card/styles.dart';

import './hero_dialogue_route.dart';
import './models.dart';

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
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _TodoPopupCard(todo: todo),
            ),
          ),
        );
      },
      child: Hero(
        // createRectTween: (begin, end) {
        //   return CustomRectTween(begin: begin, end: end);
        // },
        tag: todo.id,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            //color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: const <Widget>[
                //_TodoTitle(title: todo.description),
                SizedBox(
                  height: 150,
                  child: Placeholder(
                    color: Colors.blue,
                  ),
                ),

                //if (todo.items != null) ...[
                //const Divider(),
                //_TodoItemsBox(items: todo.items),
              ]),
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
  });
  final Todo todo;

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
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.all(30.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Placeholder(),
              // Column(
              //   // mainAxisSize: MainAxisSize,
              //   children: [
              //     _TodoTitle(title: todo.description),
              //     const SizedBox(
              //       height: 8,
              //     ),
              //     //if (todo.items != null) ...[
              //     //const Divider(),
              //     //_TodoItemsBox(items: todo.items),
              //     Container(
              //       margin: const EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         color: Colors.black12,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: SizedBox(
              //         height: 190,
              //         child: ListView(
              //           children: const [
              //             Placeholder(
              //               color: Colors.blue,
              //             ),
              //             Placeholder(
              //               color: Colors.blue,
              //             ),
              //             Placeholder(
              //               color: Colors.blue,
              //             ),
              //           ],
              //         ),
              //       ),
              //       // const TextField(
              //       //   maxLines: 8,
              //       //   cursorColor: Colors.white,
              //       //   decoration: InputDecoration(
              //       //       contentPadding: EdgeInsets.all(8),
              //       //       hintText: 'Write a note...',
              //       //       border: InputBorder.none),
              //       // ),
              //     ),
              //   ],
              // ),
            ),
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
