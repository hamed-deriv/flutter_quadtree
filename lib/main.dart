import 'dart:async';
import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quadtree/quadtree.dart';
import 'package:flutter_quadtree/quadtree_draw.dart';

void main() => runApp(GameWidget(game: QuadtreeGame()));

class QuadtreeGame extends FlameGame with DragCallbacks {
  late final Quadtree quadtree;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    quadtree =
        Quadtree(boundary: Rectangle(x: 400, y: 400, width: 400, height: 400));

    add(QuadtreeDraw(quadtree));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    for (int i = 0; i < 10; i++) {
      quadtree.inser(
        Point(
          x: event.localPosition.x + Random().nextInt(20) - 10,
          y: event.localPosition.y + Random().nextInt(20) - 10,
        ),
      );
    }
  }
}
