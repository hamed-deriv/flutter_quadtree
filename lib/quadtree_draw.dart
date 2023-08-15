import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quadtree/quadtree.dart';

class QuadtreeDraw extends PositionComponent {
  QuadtreeDraw(this.quadtree);

  final Quadtree quadtree;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _drawBoundray(canvas);

    for (final point in quadtree.points) {
      canvas.drawCircle(
        Offset(point.x, point.y),
        2,
        BasicPalette.white.paint()..color = Colors.blue.withOpacity(0.1),
      );
    }
  }

  void _drawBoundray(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(
          quadtree.boundary.x,
          quadtree.boundary.y,
        ),
        width: quadtree.boundary.width * 2,
        height: quadtree.boundary.height * 2,
      ),
      BasicPalette.white.paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white.withOpacity(0.2),
    );

    if (quadtree.isDivided) {
      for (final node in quadtree.quadrants) {
        QuadtreeDraw(node).render(canvas);
      }
    }
  }
}
