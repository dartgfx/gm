part of 'vec.dart';

/// 4-component float vector.
final class vec4 extends vecf {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec4(this.x, [double? y, double? z, double? w])
      : y = y ?? x,
        z = z ?? x,
        w = w ?? x;

  static const zero = vec4(0, 0, 0, 0);
  static const one = vec4(1, 1, 1, 1);
  static const unitX = vec4(1, 0, 0, 0);
  static const unitY = vec4(0, 1, 0, 0);
  static const unitZ = vec4(0, 0, 1, 0);
  static const unitW = vec4(0, 0, 0, 1);

  final double x, y, z, w;

  // Color aliases
  double get r => x;
  double get g => y;
  double get b => z;
  double get a => w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator +(vec4 other) =>
      vec4(x + other.x, y + other.y, z + other.z, w + other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator -(vec4 other) =>
      vec4(x - other.x, y - other.y, z - other.z, w - other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator -() => vec4(-x, -y, -z, -w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator *(Object o) => switch (o) {
        vec4 v => vec4(x * v.x, y * v.y, z * v.z, w * v.w),
        double s => vec4(x * s, y * s, z * s, w * s),
        int s => vec4(x * s, y * s, z * s, w * s),
        _ => throw ArgumentError('vec4 * ${o.runtimeType}'),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator /(Object o) => switch (o) {
        vec4 v => vec4(x / v.x, y / v.y, z / v.z, w / v.w),
        double s => vec4(x / s, y / s, z / s, w / s),
        int s => vec4(x / s, y / s, z / s, w / s),
        _ => throw ArgumentError('vec4 / ${o.runtimeType}'),
      };

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get length => math.sqrt(x * x + y * y + z * z + w * w);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get lengthSquared => x * x + y * y + z * z + w * w;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 get normalized {
    final invL = _safeInv(math.sqrt(x * x + y * y + z * z + w * w));
    return vec4(x * invL, y * invL, z * invL, w * invL);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double dotWith(vec4 other) =>
      x * other.x + y * other.y + z * other.z + w * other.w;

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double distanceTo(vec4 other) {
    final dx = x - other.x,
        dy = y - other.y,
        dz = z - other.z,
        dw = w - other.w;
    return math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 reflectOn(vec4 n) {
    final d = x * n.x + y * n.y + z * n.z + w * n.w;
    return vec4(
      x - 2.0 * d * n.x,
      y - 2.0 * d * n.y,
      z - 2.0 * d * n.z,
      w - 2.0 * d * n.w,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 mixWith(vec4 other, double t) {
    final s = 1.0 - t;
    return vec4(
      x * s + other.x * t,
      y * s + other.y * t,
      z * s + other.z * t,
      w * s + other.w * t,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 mixWithVec(vec4 other, vec4 t) => vec4(
        x * (1.0 - t.x) + other.x * t.x,
        y * (1.0 - t.y) + other.y * t.y,
        z * (1.0 - t.z) + other.z * t.z,
        w * (1.0 - t.w) + other.w * t.w,
      );

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 smoothstepWith(vec4 e0, vec4 e1) => vec4(
        _ss(x, e0.x, e1.x),
        _ss(y, e0.y, e1.y),
        _ss(z, e0.z, e1.z),
        _ss(w, e0.w, e1.w),
      );

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double operator [](int i) => switch (i) {
        0 => x,
        1 => y,
        2 => z,
        3 => w,
        _ => throw RangeError.index(i, this, 'i', null, 4),
      };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 withX(double v) => vec4(v, y, z, w);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 withY(double v) => vec4(x, v, z, w);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 withZ(double v) => vec4(x, y, v, w);
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 withW(double v) => vec4(x, y, z, v);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 normalizedOr(vec4 fallback) {
    final ls = x * x + y * y + z * z + w * w;
    if (ls < 1e-20) return fallback;
    final invL = 1.0 / math.sqrt(ls);
    return vec4(x * invL, y * invL, z * invL, w * invL);
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  bool isNearZero([double eps = 1e-10]) =>
      x * x + y * y + z * z + w * w < eps * eps;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get minComponent => math.min(x, math.min(y, math.min(z, w)));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get maxComponent => math.max(x, math.max(y, math.max(z, w)));

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 get reciprocal => vec4(1.0 / x, 1.0 / y, 1.0 / z, 1.0 / w);

  @override
  bool operator ==(Object other) =>
      other is vec4 &&
      x == other.x &&
      y == other.y &&
      z == other.z &&
      w == other.w;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  String get display => 'vec4($x, $y, $z, $w)';

  @override
  String toString() => display;
}
