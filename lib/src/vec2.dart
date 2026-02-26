part of 'vec.dart';

/// 2-component float vector.
final class vec2 extends vecf {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec2(this.x, [double? y]) : y = y ?? x;

  static const zero = vec2(0, 0);

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
  vec2 operator *(vec2 other) => vec2(x * other.x, y * other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator /(vec2 other) => vec2(x / other.x, y / other.y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get magnitude => math.sqrt(x * x + y * y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 get normalized {
    final l = math.sqrt(x * x + y * y);
    return l == 0 ? vec2.zero : vec2(x / l, y / l);
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

  @override
  bool operator ==(Object other) =>
      other is vec2 && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  String get display => 'vec2($x, $y)';
}
