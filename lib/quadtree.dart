class Point {
  Point({required this.x, required this.y});

  double x;
  double y;
}

class Rectangle {
  Rectangle({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  double x;
  double y;
  double width;
  double height;

  bool contains(Point point) =>
      point.x >= x - width &&
      point.x <= x + width &&
      point.y >= y - height &&
      point.y <= y + height;
}

class Quadtree {
  Quadtree({
    required this.boundary,
    this.capacity = 4,
  });

  final Rectangle boundary;
  final int capacity;

  final List<Point> _points = [];
  final List<Quadtree> _quadrants = [];

  bool _isDivided = false;

  bool get isDivided => _isDivided;

  List<Point> get points => _points;

  List<Quadtree> get quadrants => _quadrants;

  bool inser(Point point) {
    if (_points.length < capacity) {
      _points.add(point);
    } else {
      if (!_isDivided) {
        subdivide();

        _isDivided = true;
      }

      for (final Quadtree quadtree in _quadrants) {
        if (quadtree.boundary.contains(point)) {
          if (quadtree.inser(point)) {
            return true;
          }
        }
      }
    }

    return _isDivided;
  }

  void subdivide() {
    final x = boundary.x;
    final y = boundary.y;
    final w = boundary.width;
    final h = boundary.height;

    _quadrants.add(
      Quadtree(
        boundary:
            Rectangle(x: x + w / 2, y: y + h / 2, width: w / 2, height: h / 2),
        capacity: capacity,
      ),
    );

    _quadrants.add(
      Quadtree(
        boundary:
            Rectangle(x: x - w / 2, y: y + h / 2, width: w / 2, height: h / 2),
        capacity: capacity,
      ),
    );

    _quadrants.add(
      Quadtree(
        boundary:
            Rectangle(x: x - w / 2, y: y - h / 2, width: w / 2, height: h / 2),
        capacity: capacity,
      ),
    );

    _quadrants.add(
      Quadtree(
        boundary:
            Rectangle(x: x + w / 2, y: y - h / 2, width: w / 2, height: h / 2),
        capacity: capacity,
      ),
    );
  }
}
