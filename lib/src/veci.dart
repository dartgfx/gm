// GENERATED CODE - DO NOT MODIFY BY HAND
// Run: dart tool/generate_vec.dart

part of 'vec.dart';

/// 2-component signed integer vector.
final class vec2i extends veci {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec2i(this.x, [int? y]) : y = y ?? x;

  static const zero = vec2i(0, 0);

  final int x, y;

  int get r => x;
  int get g => y;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator +(vec2i other) => vec2i(x + other.x, y + other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator -(vec2i other) => vec2i(x - other.x, y - other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator -() => vec2i(-x, -y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator *(Object o) => switch (o) {
    vec2i v => vec2i(x * v.x, y * v.y),
    int s => vec2i(x * s, y * s),
    _ => throw ArgumentError('vec2i * ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator /(Object o) => switch (o) {
    vec2i v => vec2i(x ~/ v.x, y ~/ v.y),
    int s => vec2i(x ~/ s, y ~/ s),
    _ => throw ArgumentError('vec2i / ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator %(vec2i other) => vec2i(x % other.x, y % other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator &(vec2i other) => vec2i(x & other.x, y & other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator |(vec2i other) => vec2i(x | other.x, y | other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator ^(vec2i other) => vec2i(x ^ other.x, y ^ other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator <<(vec2i other) => vec2i(x << other.x, y << other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator >>(vec2i other) => vec2i(x >> other.x, y >> other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2i operator ~() => vec2i(~x, ~y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec2i other) => x * other.x + y * other.y;

  @override
  bool operator ==(Object other) => other is vec2i && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  String get display => 'vec2i($x, $y)';

  @override
  String toString() => display;
}

/// 3-component signed integer vector.
final class vec3i extends veci {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3i(this.x, [int? y, int? z]) : y = y ?? x, z = z ?? x;

  static const zero = vec3i(0, 0, 0);

  final int x, y, z;

  int get r => x;
  int get g => y;
  int get b => z;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator +(vec3i other) => vec3i(x + other.x, y + other.y, z + other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator -(vec3i other) => vec3i(x - other.x, y - other.y, z - other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator -() => vec3i(-x, -y, -z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator *(Object o) => switch (o) {
    vec3i v => vec3i(x * v.x, y * v.y, z * v.z),
    int s => vec3i(x * s, y * s, z * s),
    _ => throw ArgumentError('vec3i * ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator /(Object o) => switch (o) {
    vec3i v => vec3i(x ~/ v.x, y ~/ v.y, z ~/ v.z),
    int s => vec3i(x ~/ s, y ~/ s, z ~/ s),
    _ => throw ArgumentError('vec3i / ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator %(vec3i other) => vec3i(x % other.x, y % other.y, z % other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator &(vec3i other) => vec3i(x & other.x, y & other.y, z & other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator |(vec3i other) => vec3i(x | other.x, y | other.y, z | other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator ^(vec3i other) => vec3i(x ^ other.x, y ^ other.y, z ^ other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator <<(vec3i other) => vec3i(x << other.x, y << other.y, z << other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator >>(vec3i other) => vec3i(x >> other.x, y >> other.y, z >> other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3i operator ~() => vec3i(~x, ~y, ~z);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec3i other) => x * other.x + y * other.y + z * other.z;

  @override
  bool operator ==(Object other) => other is vec3i && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  String get display => 'vec3i($x, $y, $z)';

  @override
  String toString() => display;
}

/// 4-component signed integer vector.
final class vec4i extends veci {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec4i(this.x, [int? y, int? z, int? w]) : y = y ?? x, z = z ?? x, w = w ?? x;

  static const zero = vec4i(0, 0, 0, 0);

  final int x, y, z, w;

  int get r => x;
  int get g => y;
  int get b => z;
  int get a => w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator +(vec4i other) => vec4i(x + other.x, y + other.y, z + other.z, w + other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator -(vec4i other) => vec4i(x - other.x, y - other.y, z - other.z, w - other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator -() => vec4i(-x, -y, -z, -w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator *(Object o) => switch (o) {
    vec4i v => vec4i(x * v.x, y * v.y, z * v.z, w * v.w),
    int s => vec4i(x * s, y * s, z * s, w * s),
    _ => throw ArgumentError('vec4i * ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator /(Object o) => switch (o) {
    vec4i v => vec4i(x ~/ v.x, y ~/ v.y, z ~/ v.z, w ~/ v.w),
    int s => vec4i(x ~/ s, y ~/ s, z ~/ s, w ~/ s),
    _ => throw ArgumentError('vec4i / ${o.runtimeType}'),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator %(vec4i other) => vec4i(x % other.x, y % other.y, z % other.z, w % other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator &(vec4i other) => vec4i(x & other.x, y & other.y, z & other.z, w & other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator |(vec4i other) => vec4i(x | other.x, y | other.y, z | other.z, w | other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator ^(vec4i other) => vec4i(x ^ other.x, y ^ other.y, z ^ other.z, w ^ other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator <<(vec4i other) => vec4i(x << other.x, y << other.y, z << other.z, w << other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator >>(vec4i other) => vec4i(x >> other.x, y >> other.y, z >> other.z, w >> other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4i operator ~() => vec4i(~x, ~y, ~z, ~w);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec4i other) => x * other.x + y * other.y + z * other.z + w * other.w;

  @override
  bool operator ==(Object other) => other is vec4i && x == other.x && y == other.y && z == other.z && w == other.w;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  String get display => 'vec4i($x, $y, $z, $w)';

  @override
  String toString() => display;
}
