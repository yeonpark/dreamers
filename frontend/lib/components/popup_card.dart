import 'package:flutter/material.dart';
//import 'package:popup_card/styles.dart';

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
          // Hero widget is used to animate the transition
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
        const TodoCard(
          todo: Todo(id: "Hi", description: "test"),
          cardcolor: Colors.blue,
          popupcardcolor: Colors.black,
        ),
      ] else if (index == 1) ...[
        const TodoCard(
          todo: Todo(id: "Hi", description: "test"),
          cardcolor: Colors.red,
          popupcardcolor: Colors.green,
        ),
        // SizedBox(
        //   height: 190,
        //   child: ListView(
        //     children: const [
        //       Placeholder(
        //         color: Colors.blue,
        //       ),
        //       Placeholder(
        //         color: Colors.blue,
        //       ),
        //       Placeholder(
        //         color: Colors.blue,
        //       ),
        //     ],
        //   ),
        // ),
      ] else ...[
        const TodoCard(
          todo: Todo(id: "Hi", description: "test"),
          cardcolor: Colors.pink,
          popupcardcolor: Colors.purple,
        ),
      ]
    ]);
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    // RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}

class Todo {
  /// {@macro todo}
  const Todo({
    required this.id,
    required this.description,
  });

  /// The id of this todo.
  final String id;

  /// The description of this todo.
  final String description;
}
