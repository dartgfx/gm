part of 'vec.dart';

/// 3-component float vector.
final class vec3 extends vecf {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3(this.x, [double? y, double? z])
      : y = y ?? x,
        z = z ?? x;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3.raw(this.x, this.y, this.z);

  static const zero = vec3(0, 0, 0);
  static const one = vec3(1, 1, 1);
  static const unitX = vec3(1, 0, 0);
  static const unitY = vec3(0, 1, 0);
  static const unitZ = vec3(0, 0, 1);

  final double x, y, z;

  // Color aliases
  double get r => x;
  double get g => y;
  double get b => z;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator +(vec3 other) => vec3(x + other.x, y + other.y, z + other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator -(vec3 other) => vec3(x - other.x, y - other.y, z - other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator -() => vec3(-x, -y, -z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator *(Object o) => switch (o) {
        vec3 v => vec3(x * v.x, y * v.y, z * v.z),
        double s => vec3(x * s, y * s, z * s),
        int s => vec3(x * s, y * s, z * s),
        _ => throw ArgumentError('vec3 * ${o.runtimeType}'),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator /(Object o) => switch (o) {
        vec3 v => vec3(x / v.x, y / v.y, z / v.z),
        double s => vec3(x / s, y / s, z / s),
        int s => vec3(x / s, y / s, z / s),
        _ => throw ArgumentError('vec3 / ${o.runtimeType}'),
      };

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get length => math.sqrt(x * x + y * y + z * z);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get lengthSquared => x * x + y * y + z * z;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 get normalized {
    final invL = _safeInv(math.sqrt(x * x + y * y + z * z));
    return vec3(x * invL, y * invL, z * invL);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double dotWith(vec3 other) => x * other.x + y * other.y + z * other.z;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double distanceTo(vec3 other) {
    final dx = x - other.x, dy = y - other.y, dz = z - other.z;
    return math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 reflectOn(vec3 n) {
    final d = x * n.x + y * n.y + z * n.z;
    return vec3(x - 2.0 * d * n.x, y - 2.0 * d * n.y, z - 2.0 * d * n.z);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 mixWith(vec3 other, double t) {
    final s = 1.0 - t;
    return vec3(x * s + other.x * t, y * s + other.y * t, z * s + other.z * t);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 mixWithVec(vec3 other, vec3 t) => vec3(
        x * (1.0 - t.x) + other.x * t.x,
        y * (1.0 - t.y) + other.y * t.y,
        z * (1.0 - t.z) + other.z * t.z,
      );

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 smoothstepWith(vec3 e0, vec3 e1) =>
      vec3(_ss(x, e0.x, e1.x), _ss(y, e0.y, e1.y), _ss(z, e0.z, e1.z));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double operator [](int i) => switch (i) {
        0 => x,
        1 => y,
        2 => z,
        _ => throw RangeError.index(i, this, 'i', null, 3),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 withX(double v) => vec3(v, y, z);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 withY(double v) => vec3(x, v, z);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 withZ(double v) => vec3(x, y, v);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 normalizedOr(vec3 fallback) {
    final ls = x * x + y * y + z * z;
    if (ls < 1e-20) return fallback;
    final invL = 1.0 / math.sqrt(ls);
    return vec3(x * invL, y * invL, z * invL);
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  bool isNearZero([double eps = 1e-10]) => x * x + y * y + z * z < eps * eps;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get minComponent => math.min(x, math.min(y, z));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get maxComponent => math.max(x, math.max(y, z));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 get reciprocal => vec3(1.0 / x, 1.0 / y, 1.0 / z);

  @override
  bool operator ==(Object other) =>
      other is vec3 && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  String get display => 'vec3($x, $y, $z)';

  @override
  String toString() => display;
}
