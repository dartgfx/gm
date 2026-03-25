part of 'vec.dart';

/// 2-component float vector.
final class vec2 extends vecf {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec2(this.x, [double? y]) : y = y ?? x;

  static const zero = vec2(0, 0);
  static const one = vec2(1, 1);
  static const unitX = vec2(1, 0);
  static const unitY = vec2(0, 1);

  final double x, y;

  // Texture coordinate aliases
  double get u => x;
  double get v => y;

  // Color aliases
  double get r => x;
  double get g => y;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator +(vec2 other) => vec2(x + other.x, y + other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator -(vec2 other) => vec2(x - other.x, y - other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator -() => vec2(-x, -y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator *(Object o) => switch (o) {
        vec2 v => vec2(x * v.x, y * v.y),
        double s => vec2(x * s, y * s),
        int s => vec2(x * s, y * s),
        _ => throw ArgumentError('vec2 * ${o.runtimeType}'),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator /(Object o) => switch (o) {
        vec2 v => vec2(x / v.x, y / v.y),
        double s => vec2(x / s, y / s),
        int s => vec2(x / s, y / s),
        _ => throw ArgumentError('vec2 / ${o.runtimeType}'),
      };

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get length => math.sqrt(x * x + y * y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get lengthSquared => x * x + y * y;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 get normalized {
    final invL = _safeInv(math.sqrt(x * x + y * y));
    return vec2(x * invL, y * invL);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double dotWith(vec2 other) => x * other.x + y * other.y;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double distanceTo(vec2 other) {
    final dx = x - other.x, dy = y - other.y;
    return math.sqrt(dx * dx + dy * dy);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 reflectOn(vec2 n) {
    final d = x * n.x + y * n.y;
    return vec2(x - 2.0 * d * n.x, y - 2.0 * d * n.y);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 mixWith(vec2 other, double t) {
    final s = 1.0 - t;
    return vec2(x * s + other.x * t, y * s + other.y * t);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 mixWithVec(vec2 other, vec2 t) =>
      vec2(x * (1.0 - t.x) + other.x * t.x, y * (1.0 - t.y) + other.y * t.y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 smoothstepWith(vec2 e0, vec2 e1) =>
      vec2(_ss(x, e0.x, e1.x), _ss(y, e0.y, e1.y));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double operator [](int i) => switch (i) {
        0 => x,
        1 => y,
        _ => throw RangeError.index(i, this, 'i', null, 2),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 withX(double v) => vec2(v, y);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 withY(double v) => vec2(x, v);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 normalizedOr(vec2 fallback) {
    final ls = x * x + y * y;
    if (ls < 1e-20) return fallback;
    final invL = 1.0 / math.sqrt(ls);
    return vec2(x * invL, y * invL);
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  bool isNearZero([double eps = 1e-10]) => x * x + y * y < eps * eps;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get minComponent => math.min(x, y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get maxComponent => math.max(x, y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 get reciprocal => vec2(1.0 / x, 1.0 / y);

  @override
  bool operator ==(Object other) =>
      other is vec2 && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  String get display => 'vec2($x, $y)';

  @override
  String toString() => display;
}
