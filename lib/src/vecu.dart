// GENERATED CODE - DO NOT MODIFY BY HAND
// Run: dart tool/generate_vec.dart

part of 'vec.dart';

/// 2-component unsigned integer vector.
final class vec2u extends vecu {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec2u(this.x, [int? y]) : y = y ?? x;

  static const zero = vec2u(0, 0);

  final int x, y;

  int get r => x;
  int get g => y;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator +(vec2u other) => vec2u(x + other.x, y + other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator -(vec2u other) => vec2u(x - other.x, y - other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator -() => vec2u(-x, -y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator *(vec2u other) => vec2u(x * other.x, y * other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator /(vec2u other) => vec2u(x ~/ other.x, y ~/ other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator %(vec2u other) => vec2u(x % other.x, y % other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator &(vec2u other) => vec2u(x & other.x, y & other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator |(vec2u other) => vec2u(x | other.x, y | other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator ^(vec2u other) => vec2u(x ^ other.x, y ^ other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator <<(vec2u other) => vec2u(x << other.x, y << other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator >>(vec2u other) => vec2u(x >> other.x, y >> other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator >>>(vec2u other) => vec2u(x >>> other.x, y >>> other.y);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2u operator ~() => vec2u(~x, ~y);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec2u other) => x * other.x + y * other.y;

  @override
  bool operator ==(Object other) => other is vec2u && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  String get display => 'vec2u($x, $y)';
}

/// 3-component unsigned integer vector.
final class vec3u extends vecu {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec3u(this.x, [int? y, int? z]) : y = y ?? x, z = z ?? x;

  static const zero = vec3u(0, 0, 0);

  final int x, y, z;

  int get r => x;
  int get g => y;
  int get b => z;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator +(vec3u other) => vec3u(x + other.x, y + other.y, z + other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator -(vec3u other) => vec3u(x - other.x, y - other.y, z - other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator -() => vec3u(-x, -y, -z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator *(vec3u other) => vec3u(x * other.x, y * other.y, z * other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator /(vec3u other) => vec3u(x ~/ other.x, y ~/ other.y, z ~/ other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator %(vec3u other) => vec3u(x % other.x, y % other.y, z % other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator &(vec3u other) => vec3u(x & other.x, y & other.y, z & other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator |(vec3u other) => vec3u(x | other.x, y | other.y, z | other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator ^(vec3u other) => vec3u(x ^ other.x, y ^ other.y, z ^ other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator <<(vec3u other) => vec3u(x << other.x, y << other.y, z << other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator >>(vec3u other) => vec3u(x >> other.x, y >> other.y, z >> other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator >>>(vec3u other) => vec3u(x >>> other.x, y >>> other.y, z >>> other.z);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3u operator ~() => vec3u(~x, ~y, ~z);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec3u other) => x * other.x + y * other.y + z * other.z;

  @override
  bool operator ==(Object other) => other is vec3u && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  String get display => 'vec3u($x, $y, $z)';
}

/// 4-component unsigned integer vector.
final class vec4u extends vecu {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const vec4u(this.x, [int? y, int? z, int? w]) : y = y ?? x, z = z ?? x, w = w ?? x;

  static const zero = vec4u(0, 0, 0, 0);

  final int x, y, z, w;

  int get r => x;
  int get g => y;
  int get b => z;
  int get a => w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator +(vec4u other) => vec4u(x + other.x, y + other.y, z + other.z, w + other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator -(vec4u other) => vec4u(x - other.x, y - other.y, z - other.z, w - other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator -() => vec4u(-x, -y, -z, -w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator *(vec4u other) => vec4u(x * other.x, y * other.y, z * other.z, w * other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator /(vec4u other) => vec4u(x ~/ other.x, y ~/ other.y, z ~/ other.z, w ~/ other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator %(vec4u other) => vec4u(x % other.x, y % other.y, z % other.z, w % other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator &(vec4u other) => vec4u(x & other.x, y & other.y, z & other.z, w & other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator |(vec4u other) => vec4u(x | other.x, y | other.y, z | other.z, w | other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator ^(vec4u other) => vec4u(x ^ other.x, y ^ other.y, z ^ other.z, w ^ other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator <<(vec4u other) => vec4u(x << other.x, y << other.y, z << other.z, w << other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator >>(vec4u other) => vec4u(x >> other.x, y >> other.y, z >> other.z, w >> other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator >>>(vec4u other) => vec4u(x >>> other.x, y >>> other.y, z >>> other.z, w >>> other.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4u operator ~() => vec4u(~x, ~y, ~z, ~w);

  @override
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  int dotWith(vec4u other) => x * other.x + y * other.y + z * other.z + w * other.w;

  @override
  bool operator ==(Object other) => other is vec4u && x == other.x && y == other.y && z == other.z && w == other.w;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  String get display => 'vec4u($x, $y, $z, $w)';
}
