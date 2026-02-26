part of 'vec.dart';

/// 3-component float vector.
final class vec3 extends vecf {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3(this.x, [double? y, double? z]) : y = y ?? x, z = z ?? x;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3.raw(this.x, this.y, this.z);

  static const zero = vec3(0, 0, 0);

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
  vec3 operator *(vec3 other) => vec3(x * other.x, y * other.y, z * other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator /(vec3 other) => vec3(x / other.x, y / other.y, z / other.z);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get magnitude => math.sqrt(x * x + y * y + z * z);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 get normalized {
    final l = math.sqrt(x * x + y * y + z * z);
    return l == 0 ? vec3.zero : vec3(x / l, y / l, z / l);
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

  @override
  bool operator ==(Object other) =>
      other is vec3 && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  String get display => 'vec3($x, $y, $z)';
}
