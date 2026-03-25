part of 'vec.dart';

/// 2-component boolean vector.
final class vec2b extends vecb {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec2b(this.x, [bool? y]) : y = y ?? x;

  static const allTrue = vec2b(true, true);
  static const allFalse = vec2b(false, false);

  final bool x, y;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2b operator &(vec2b other) => vec2b(x && other.x, y && other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2b operator |(vec2b other) => vec2b(x || other.x, y || other.y);

  @override
  bool get any => x || y;

  @override
  bool get all => x && y;

  @override
  vec2b get not => vec2b(!x, !y);

  @override
  bool operator ==(Object other) =>
      other is vec2b && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  String get display => 'vec2b($x, $y)';

  @override
  String toString() => display;
}

/// 3-component boolean vector.
final class vec3b extends vecb {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3b(this.x, [bool? y, bool? z]) : y = y ?? x, z = z ?? x;

  static const allTrue = vec3b(true, true, true);
  static const allFalse = vec3b(false, false, false);

  final bool x, y, z;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3b operator &(vec3b other) =>
      vec3b(x && other.x, y && other.y, z && other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3b operator |(vec3b other) =>
      vec3b(x || other.x, y || other.y, z || other.z);

  @override
  bool get any => x || y || z;

  @override
  bool get all => x && y && z;

  @override
  vec3b get not => vec3b(!x, !y, !z);

  @override
  bool operator ==(Object other) =>
      other is vec3b && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  String get display => 'vec3b($x, $y, $z)';

  @override
  String toString() => display;
}

/// 4-component boolean vector.
final class vec4b extends vecb {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec4b(this.x, [bool? y, bool? z, bool? w])
    : y = y ?? x,
      z = z ?? x,
      w = w ?? x;

  static const allTrue = vec4b(true, true, true, true);
  static const allFalse = vec4b(false, false, false, false);

  final bool x, y, z, w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4b operator &(vec4b other) =>
      vec4b(x && other.x, y && other.y, z && other.z, w && other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4b operator |(vec4b other) =>
      vec4b(x || other.x, y || other.y, z || other.z, w || other.w);

  @override
  bool get any => x || y || z || w;

  @override
  bool get all => x && y && z && w;

  @override
  vec4b get not => vec4b(!x, !y, !z, !w);

  @override
  bool operator ==(Object other) =>
      other is vec4b &&
      x == other.x &&
      y == other.y &&
      z == other.z &&
      w == other.w;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  String get display => 'vec4b($x, $y, $z, $w)';

  @override
  String toString() => display;
}
