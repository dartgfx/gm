// GENERATED CODE - DO NOT MODIFY BY HAND
// Run: dart tool/generate_mat.dart

part of 'mat.dart';

/// 2x3 float matrix (2 columns of vec3).
final class mat2x3 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat2x3(this.c0, this.c1);

  static const zero = mat2x3(vec3.zero, vec3.zero);

  final vec3 c0, c1;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    _ => throw RangeError.index(index, this, 'index', null, 2),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x3 operator +(mat2x3 other) => mat2x3(c0 + other.c0, c1 + other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x3 operator -(mat2x3 other) => mat2x3(c0 - other.c0, c1 - other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x3 operator -() => mat2x3(-c0, -c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 transform(vec2 v) => vec3(
    c0.x * v.x + c1.x * v.y,
    c0.y * v.x + c1.y * v.y,
    c0.z * v.x + c1.z * v.y,
  );

  mat3x2 get transposed => mat3x2(
    vec2(c0.x, c1.x),
    vec2(c0.y, c1.y),
    vec2(c0.z, c1.z),
  );

  @override
  bool operator ==(Object other) => other is mat2x3 && c0 == other.c0 && c1 == other.c1;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode;

  String get display => 'mat2x3($c0, $c1)';

  @override
  String toString() => display;
}

/// 2x4 float matrix (2 columns of vec4).
final class mat2x4 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat2x4(this.c0, this.c1);

  static const zero = mat2x4(vec4.zero, vec4.zero);

  final vec4 c0, c1;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    _ => throw RangeError.index(index, this, 'index', null, 2),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x4 operator +(mat2x4 other) => mat2x4(c0 + other.c0, c1 + other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x4 operator -(mat2x4 other) => mat2x4(c0 - other.c0, c1 - other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x4 operator -() => mat2x4(-c0, -c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 transform(vec2 v) => vec4(
    c0.x * v.x + c1.x * v.y,
    c0.y * v.x + c1.y * v.y,
    c0.z * v.x + c1.z * v.y,
    c0.w * v.x + c1.w * v.y,
  );

  mat4x2 get transposed => mat4x2(
    vec2(c0.x, c1.x),
    vec2(c0.y, c1.y),
    vec2(c0.z, c1.z),
    vec2(c0.w, c1.w),
  );

  @override
  bool operator ==(Object other) => other is mat2x4 && c0 == other.c0 && c1 == other.c1;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode;

  String get display => 'mat2x4($c0, $c1)';

  @override
  String toString() => display;
}

/// 3x2 float matrix (3 columns of vec2).
final class mat3x2 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat3x2(this.c0, this.c1, this.c2);

  static const zero = mat3x2(vec2.zero, vec2.zero, vec2.zero);

  final vec2 c0, c1, c2;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    _ => throw RangeError.index(index, this, 'index', null, 3),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x2 operator +(mat3x2 other) => mat3x2(c0 + other.c0, c1 + other.c1, c2 + other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x2 operator -(mat3x2 other) => mat3x2(c0 - other.c0, c1 - other.c1, c2 - other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x2 operator -() => mat3x2(-c0, -c1, -c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 transform(vec3 v) => vec2(
    c0.x * v.x + c1.x * v.y + c2.x * v.z,
    c0.y * v.x + c1.y * v.y + c2.y * v.z,
  );

  mat2x3 get transposed => mat2x3(
    vec3(c0.x, c1.x, c2.x),
    vec3(c0.y, c1.y, c2.y),
  );

  @override
  bool operator ==(Object other) => other is mat3x2 && c0 == other.c0 && c1 == other.c1 && c2 == other.c2;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode;

  String get display => 'mat3x2($c0, $c1, $c2)';

  @override
  String toString() => display;
}

/// 3x4 float matrix (3 columns of vec4).
final class mat3x4 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat3x4(this.c0, this.c1, this.c2);

  static const zero = mat3x4(vec4.zero, vec4.zero, vec4.zero);

  final vec4 c0, c1, c2;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    _ => throw RangeError.index(index, this, 'index', null, 3),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x4 operator +(mat3x4 other) => mat3x4(c0 + other.c0, c1 + other.c1, c2 + other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x4 operator -(mat3x4 other) => mat3x4(c0 - other.c0, c1 - other.c1, c2 - other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x4 operator -() => mat3x4(-c0, -c1, -c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 transform(vec3 v) => vec4(
    c0.x * v.x + c1.x * v.y + c2.x * v.z,
    c0.y * v.x + c1.y * v.y + c2.y * v.z,
    c0.z * v.x + c1.z * v.y + c2.z * v.z,
    c0.w * v.x + c1.w * v.y + c2.w * v.z,
  );

  mat4x3 get transposed => mat4x3(
    vec3(c0.x, c1.x, c2.x),
    vec3(c0.y, c1.y, c2.y),
    vec3(c0.z, c1.z, c2.z),
    vec3(c0.w, c1.w, c2.w),
  );

  @override
  bool operator ==(Object other) => other is mat3x4 && c0 == other.c0 && c1 == other.c1 && c2 == other.c2;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode;

  String get display => 'mat3x4($c0, $c1, $c2)';

  @override
  String toString() => display;
}

/// 4x2 float matrix (4 columns of vec2).
final class mat4x2 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat4x2(this.c0, this.c1, this.c2, this.c3);

  static const zero = mat4x2(vec2.zero, vec2.zero, vec2.zero, vec2.zero);

  final vec2 c0, c1, c2, c3;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    3 => c3,
    _ => throw RangeError.index(index, this, 'index', null, 4),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x2 operator +(mat4x2 other) => mat4x2(c0 + other.c0, c1 + other.c1, c2 + other.c2, c3 + other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x2 operator -(mat4x2 other) => mat4x2(c0 - other.c0, c1 - other.c1, c2 - other.c2, c3 - other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x2 operator -() => mat4x2(-c0, -c1, -c2, -c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 transform(vec4 v) => vec2(
    c0.x * v.x + c1.x * v.y + c2.x * v.z + c3.x * v.w,
    c0.y * v.x + c1.y * v.y + c2.y * v.z + c3.y * v.w,
  );

  mat2x4 get transposed => mat2x4(
    vec4(c0.x, c1.x, c2.x, c3.x),
    vec4(c0.y, c1.y, c2.y, c3.y),
  );

  @override
  bool operator ==(Object other) => other is mat4x2 && c0 == other.c0 && c1 == other.c1 && c2 == other.c2 && c3 == other.c3;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode ^ c3.hashCode;

  String get display => 'mat4x2($c0, $c1, $c2, $c3)';

  @override
  String toString() => display;
}

/// 4x3 float matrix (4 columns of vec3).
final class mat4x3 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat4x3(this.c0, this.c1, this.c2, this.c3);

  static const zero = mat4x3(vec3.zero, vec3.zero, vec3.zero, vec3.zero);

  final vec3 c0, c1, c2, c3;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    3 => c3,
    _ => throw RangeError.index(index, this, 'index', null, 4),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x3 operator +(mat4x3 other) => mat4x3(c0 + other.c0, c1 + other.c1, c2 + other.c2, c3 + other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x3 operator -(mat4x3 other) => mat4x3(c0 - other.c0, c1 - other.c1, c2 - other.c2, c3 - other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x3 operator -() => mat4x3(-c0, -c1, -c2, -c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 transform(vec4 v) => vec3(
    c0.x * v.x + c1.x * v.y + c2.x * v.z + c3.x * v.w,
    c0.y * v.x + c1.y * v.y + c2.y * v.z + c3.y * v.w,
    c0.z * v.x + c1.z * v.y + c2.z * v.z + c3.z * v.w,
  );

  mat3x4 get transposed => mat3x4(
    vec4(c0.x, c1.x, c2.x, c3.x),
    vec4(c0.y, c1.y, c2.y, c3.y),
    vec4(c0.z, c1.z, c2.z, c3.z),
  );

  @override
  bool operator ==(Object other) => other is mat4x3 && c0 == other.c0 && c1 == other.c1 && c2 == other.c2 && c3 == other.c3;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode ^ c3.hashCode;

  String get display => 'mat4x3($c0, $c1, $c2, $c3)';

  @override
  String toString() => display;
}
