import 'dart:math' as math;

import 'functions.dart' show cross;
import 'quat.dart';
import 'vec.dart';

part 'mat_nonsquare.dart';

/// Base type for all matrix types.
sealed class mat {
  const mat();
}

/// 2x2 float matrix.
final class mat2x2 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat2x2(this.c0, this.c1);

  static const zero = mat2x2(vec2.zero, vec2.zero);
  static const identity = mat2x2(vec2(1, 0), vec2(0, 1));

  final vec2 c0, c1;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    _ => throw RangeError.index(index, this, 'index', null, 2),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x2 operator +(mat2x2 other) => mat2x2(c0 + other.c0, c1 + other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x2 operator -(mat2x2 other) => mat2x2(c0 - other.c0, c1 - other.c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x2 operator -() => mat2x2(-c0, -c1);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat2x2 operator *(mat2x2 o) => mat2x2(
    vec2(c0.x * o.c0.x + c1.x * o.c0.y, c0.y * o.c0.x + c1.y * o.c0.y),
    vec2(c0.x * o.c1.x + c1.x * o.c1.y, c0.y * o.c1.x + c1.y * o.c1.y),
  );

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2 transform(vec2 v) =>
      vec2(c0.x * v.x + c1.x * v.y, c0.y * v.x + c1.y * v.y);

  mat2x2 get transposed => mat2x2(vec2(c0.x, c1.x), vec2(c0.y, c1.y));

  double get determinant => c0.x * c1.y - c1.x * c0.y;

  mat2x2 get inversed {
    final det = determinant;
    final invDet = 1.0 / det;
    return mat2x2(
      vec2(c1.y * invDet, -c0.y * invDet),
      vec2(-c1.x * invDet, c0.x * invDet),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is mat2x2 && c0 == other.c0 && c1 == other.c1;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode;

  String get display => 'mat2x2($c0, $c1)';
}

/// 3x3 float matrix. Column-major, immutable, const-constructible.
final class mat3x3 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat3x3(this.c0, this.c1, this.c2);

  static const zero = mat3x3(vec3.zero, vec3.zero, vec3.zero);
  static const identity = mat3x3(vec3(1, 0, 0), vec3(0, 1, 0), vec3(0, 0, 1));

  final vec3 c0, c1, c2;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    _ => throw RangeError.index(index, this, 'index', null, 3),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x3 operator +(mat3x3 other) =>
      mat3x3(c0 + other.c0, c1 + other.c1, c2 + other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x3 operator -(mat3x3 other) =>
      mat3x3(c0 - other.c0, c1 - other.c1, c2 - other.c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x3 operator -() => mat3x3(-c0, -c1, -c2);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat3x3 operator *(mat3x3 o) => mat3x3(
    vec3(
      c0.x * o.c0.x + c1.x * o.c0.y + c2.x * o.c0.z,
      c0.y * o.c0.x + c1.y * o.c0.y + c2.y * o.c0.z,
      c0.z * o.c0.x + c1.z * o.c0.y + c2.z * o.c0.z,
    ),
    vec3(
      c0.x * o.c1.x + c1.x * o.c1.y + c2.x * o.c1.z,
      c0.y * o.c1.x + c1.y * o.c1.y + c2.y * o.c1.z,
      c0.z * o.c1.x + c1.z * o.c1.y + c2.z * o.c1.z,
    ),
    vec3(
      c0.x * o.c2.x + c1.x * o.c2.y + c2.x * o.c2.z,
      c0.y * o.c2.x + c1.y * o.c2.y + c2.y * o.c2.z,
      c0.z * o.c2.x + c1.z * o.c2.y + c2.z * o.c2.z,
    ),
  );

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 transform(vec3 v) => vec3(
    c0.x * v.x + c1.x * v.y + c2.x * v.z,
    c0.y * v.x + c1.y * v.y + c2.y * v.z,
    c0.z * v.x + c1.z * v.y + c2.z * v.z,
  );

  mat3x3 get transposed => mat3x3(
    vec3(c0.x, c1.x, c2.x),
    vec3(c0.y, c1.y, c2.y),
    vec3(c0.z, c1.z, c2.z),
  );

  double get determinant =>
      c0.x * (c1.y * c2.z - c2.y * c1.z) -
      c1.x * (c0.y * c2.z - c2.y * c0.z) +
      c2.x * (c0.y * c1.z - c1.y * c0.z);

  mat3x3 get inversed {
    final det = determinant;
    final invDet = 1.0 / det;
    return mat3x3(
      vec3(
        (c1.y * c2.z - c2.y * c1.z) * invDet,
        (c2.y * c0.z - c0.y * c2.z) * invDet,
        (c0.y * c1.z - c1.y * c0.z) * invDet,
      ),
      vec3(
        (c2.x * c1.z - c1.x * c2.z) * invDet,
        (c0.x * c2.z - c2.x * c0.z) * invDet,
        (c1.x * c0.z - c0.x * c1.z) * invDet,
      ),
      vec3(
        (c1.x * c2.y - c2.x * c1.y) * invDet,
        (c2.x * c0.y - c0.x * c2.y) * invDet,
        (c0.x * c1.y - c1.x * c0.y) * invDet,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is mat3x3 && c0 == other.c0 && c1 == other.c1 && c2 == other.c2;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode;

  String get display => 'mat3x3($c0, $c1, $c2)';
}

/// 4x4 float matrix.
final class mat4x4 extends mat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const mat4x4(this.c0, this.c1, this.c2, this.c3);

  static const zero = mat4x4(vec4.zero, vec4.zero, vec4.zero, vec4.zero);
  static const identity = mat4x4(
    vec4(1, 0, 0, 0),
    vec4(0, 1, 0, 0),
    vec4(0, 0, 1, 0),
    vec4(0, 0, 0, 1),
  );

  /// Constructs from 16 column-major doubles starting at [offset].
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  factory mat4x4.fromColsArray(List<double> v, [int offset = 0]) => mat4x4(
    vec4(v[offset], v[offset + 1], v[offset + 2], v[offset + 3]),
    vec4(v[offset + 4], v[offset + 5], v[offset + 6], v[offset + 7]),
    vec4(v[offset + 8], v[offset + 9], v[offset + 10], v[offset + 11]),
    vec4(v[offset + 12], v[offset + 13], v[offset + 14], v[offset + 15]),
  );

  final vec4 c0, c1, c2, c3;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 operator [](int index) => switch (index) {
    0 => c0,
    1 => c1,
    2 => c2,
    3 => c3,
    _ => throw RangeError.index(index, this, 'index', null, 4),
  };

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x4 operator +(mat4x4 other) =>
      mat4x4(c0 + other.c0, c1 + other.c1, c2 + other.c2, c3 + other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x4 operator -(mat4x4 other) =>
      mat4x4(c0 - other.c0, c1 - other.c1, c2 - other.c2, c3 - other.c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x4 operator -() => mat4x4(-c0, -c1, -c2, -c3);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  mat4x4 operator *(mat4x4 o) {
    // Each result column = this * o.column
    return mat4x4(
      vec4(
        c0.x * o.c0.x + c1.x * o.c0.y + c2.x * o.c0.z + c3.x * o.c0.w,
        c0.y * o.c0.x + c1.y * o.c0.y + c2.y * o.c0.z + c3.y * o.c0.w,
        c0.z * o.c0.x + c1.z * o.c0.y + c2.z * o.c0.z + c3.z * o.c0.w,
        c0.w * o.c0.x + c1.w * o.c0.y + c2.w * o.c0.z + c3.w * o.c0.w,
      ),
      vec4(
        c0.x * o.c1.x + c1.x * o.c1.y + c2.x * o.c1.z + c3.x * o.c1.w,
        c0.y * o.c1.x + c1.y * o.c1.y + c2.y * o.c1.z + c3.y * o.c1.w,
        c0.z * o.c1.x + c1.z * o.c1.y + c2.z * o.c1.z + c3.z * o.c1.w,
        c0.w * o.c1.x + c1.w * o.c1.y + c2.w * o.c1.z + c3.w * o.c1.w,
      ),
      vec4(
        c0.x * o.c2.x + c1.x * o.c2.y + c2.x * o.c2.z + c3.x * o.c2.w,
        c0.y * o.c2.x + c1.y * o.c2.y + c2.y * o.c2.z + c3.y * o.c2.w,
        c0.z * o.c2.x + c1.z * o.c2.y + c2.z * o.c2.z + c3.z * o.c2.w,
        c0.w * o.c2.x + c1.w * o.c2.y + c2.w * o.c2.z + c3.w * o.c2.w,
      ),
      vec4(
        c0.x * o.c3.x + c1.x * o.c3.y + c2.x * o.c3.z + c3.x * o.c3.w,
        c0.y * o.c3.x + c1.y * o.c3.y + c2.y * o.c3.z + c3.y * o.c3.w,
        c0.z * o.c3.x + c1.z * o.c3.y + c2.z * o.c3.z + c3.z * o.c3.w,
        c0.w * o.c3.x + c1.w * o.c3.y + c2.w * o.c3.z + c3.w * o.c3.w,
      ),
    );
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4 transform(vec4 v) => vec4(
    c0.x * v.x + c1.x * v.y + c2.x * v.z + c3.x * v.w,
    c0.y * v.x + c1.y * v.y + c2.y * v.z + c3.y * v.w,
    c0.z * v.x + c1.z * v.y + c2.z * v.z + c3.z * v.w,
    c0.w * v.x + c1.w * v.y + c2.w * v.z + c3.w * v.w,
  );

  mat4x4 get transposed => mat4x4(
    vec4(c0.x, c1.x, c2.x, c3.x),
    vec4(c0.y, c1.y, c2.y, c3.y),
    vec4(c0.z, c1.z, c2.z, c3.z),
    vec4(c0.w, c1.w, c2.w, c3.w),
  );

  double get determinant {
    final a00 = c0.x, a01 = c0.y, a02 = c0.z, a03 = c0.w;
    final a10 = c1.x, a11 = c1.y, a12 = c1.z, a13 = c1.w;
    final a20 = c2.x, a21 = c2.y, a22 = c2.z, a23 = c2.w;
    final a30 = c3.x, a31 = c3.y, a32 = c3.z, a33 = c3.w;

    final b00 = a00 * a11 - a01 * a10;
    final b01 = a00 * a12 - a02 * a10;
    final b02 = a00 * a13 - a03 * a10;
    final b03 = a01 * a12 - a02 * a11;
    final b04 = a01 * a13 - a03 * a11;
    final b05 = a02 * a13 - a03 * a12;
    final b06 = a20 * a31 - a21 * a30;
    final b07 = a20 * a32 - a22 * a30;
    final b08 = a20 * a33 - a23 * a30;
    final b09 = a21 * a32 - a22 * a31;
    final b10 = a21 * a33 - a23 * a31;
    final b11 = a22 * a33 - a23 * a32;

    return b00 * b11 -
        b01 * b10 +
        b02 * b09 +
        b03 * b08 -
        b04 * b07 +
        b05 * b06;
  }

  /// Decomposes an affine mat4 into translation, rotation, and scale.
  ({vec3 translation, quat rotation, vec3 scale}) get decomposed {
    final translation = vec3(c3.x, c3.y, c3.z);

    // Scale = magnitude of each column's xyz.
    var sx = math.sqrt(c0.x * c0.x + c0.y * c0.y + c0.z * c0.z);
    final sy = math.sqrt(c1.x * c1.x + c1.y * c1.y + c1.z * c1.z);
    final sz = math.sqrt(c2.x * c2.x + c2.y * c2.y + c2.z * c2.z);

    // Negate sx if upper-left 3x3 determinant is negative (reflection).
    final det3 =
        c0.x * (c1.y * c2.z - c2.y * c1.z) -
        c1.x * (c0.y * c2.z - c2.y * c0.z) +
        c2.x * (c0.y * c1.z - c1.y * c0.z);
    if (det3 < 0) sx = -sx;

    final scale = vec3(sx, sy, sz);

    // Divide columns by scale to get pure rotation mat3.
    final invSx = 1.0 / sx, invSy = 1.0 / sy, invSz = 1.0 / sz;
    final rotMat = mat3x3(
      vec3(c0.x * invSx, c0.y * invSx, c0.z * invSx),
      vec3(c1.x * invSy, c1.y * invSy, c1.z * invSy),
      vec3(c2.x * invSz, c2.y * invSz, c2.z * invSz),
    );

    return (
      translation: translation,
      rotation: quat.fromMat3(rotMat),
      scale: scale,
    );
  }

  mat4x4 get inversed {
    final a00 = c0.x, a01 = c0.y, a02 = c0.z, a03 = c0.w;
    final a10 = c1.x, a11 = c1.y, a12 = c1.z, a13 = c1.w;
    final a20 = c2.x, a21 = c2.y, a22 = c2.z, a23 = c2.w;
    final a30 = c3.x, a31 = c3.y, a32 = c3.z, a33 = c3.w;

    final b00 = a00 * a11 - a01 * a10;
    final b01 = a00 * a12 - a02 * a10;
    final b02 = a00 * a13 - a03 * a10;
    final b03 = a01 * a12 - a02 * a11;
    final b04 = a01 * a13 - a03 * a11;
    final b05 = a02 * a13 - a03 * a12;
    final b06 = a20 * a31 - a21 * a30;
    final b07 = a20 * a32 - a22 * a30;
    final b08 = a20 * a33 - a23 * a30;
    final b09 = a21 * a32 - a22 * a31;
    final b10 = a21 * a33 - a23 * a31;
    final b11 = a22 * a33 - a23 * a32;

    final invDet =
        1.0 /
        (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06);

    return mat4x4(
      vec4(
        (a11 * b11 - a12 * b10 + a13 * b09) * invDet,
        (a02 * b10 - a01 * b11 - a03 * b09) * invDet,
        (a31 * b05 - a32 * b04 + a33 * b03) * invDet,
        (a22 * b04 - a21 * b05 - a23 * b03) * invDet,
      ),
      vec4(
        (a12 * b08 - a10 * b11 - a13 * b07) * invDet,
        (a00 * b11 - a02 * b08 + a03 * b07) * invDet,
        (a32 * b02 - a30 * b05 - a33 * b01) * invDet,
        (a20 * b05 - a22 * b02 + a23 * b01) * invDet,
      ),
      vec4(
        (a10 * b10 - a11 * b08 + a13 * b06) * invDet,
        (a01 * b08 - a00 * b10 - a03 * b06) * invDet,
        (a30 * b04 - a31 * b02 + a33 * b00) * invDet,
        (a21 * b02 - a20 * b04 - a23 * b00) * invDet,
      ),
      vec4(
        (a11 * b07 - a10 * b09 - a12 * b06) * invDet,
        (a00 * b09 - a01 * b07 + a02 * b06) * invDet,
        (a31 * b01 - a30 * b03 - a32 * b00) * invDet,
        (a20 * b03 - a21 * b01 + a22 * b00) * invDet,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is mat4x4 &&
      c0 == other.c0 &&
      c1 == other.c1 &&
      c2 == other.c2 &&
      c3 == other.c3;

  @override
  int get hashCode => c0.hashCode ^ c1.hashCode ^ c2.hashCode ^ c3.hashCode;

  String get display => 'mat4x4($c0, $c1, $c2, $c3)';

  /// Perspective projection (right-handed, depth [0, 1]).
  /// [fovY] is vertical field of view in radians.
  static mat4x4 perspective({
    required double fovY,
    required double aspect,
    required double near,
    required double far,
  }) {
    final t = 1.0 / math.tan(fovY * 0.5);
    final nf = 1.0 / (near - far);
    return mat4x4(
      vec4(t / aspect, 0, 0, 0),
      vec4(0, t, 0, 0),
      vec4(0, 0, far * nf, -1),
      vec4(0, 0, near * far * nf, 0),
    );
  }

  /// Infinite perspective projection (right-handed, depth [0, 1]).
  /// Far plane at infinity — useful for reverse-Z and shadow cascades.
  static mat4x4 infinitePerspective({
    required double fovY,
    required double aspect,
    required double near,
  }) {
    final t = 1.0 / math.tan(fovY * 0.5);
    return mat4x4(
      vec4(t / aspect, 0, 0, 0),
      vec4(0, t, 0, 0),
      vec4(0, 0, -1, -1),
      vec4(0, 0, -near, 0),
    );
  }

  /// Orthographic projection (right-handed, depth [0, 1]).
  static mat4x4 ortho({
    required double left,
    required double right,
    required double bottom,
    required double top,
    required double near,
    required double far,
  }) {
    final rl = 1.0 / (right - left);
    final tb = 1.0 / (top - bottom);
    final nf = 1.0 / (near - far);
    return mat4x4(
      vec4(2.0 * rl, 0, 0, 0),
      vec4(0, 2.0 * tb, 0, 0),
      vec4(0, 0, nf, 0),
      vec4(-(right + left) * rl, -(top + bottom) * tb, near * nf, 1),
    );
  }

  /// Right-handed lookAt view matrix. Camera looks down -Z.
  static mat4x4 lookAt({
    required vec3 eye,
    required vec3 target,
    required vec3 up,
  }) {
    final f = (target - eye).normalized;
    final s = cross(f, up).normalized;
    final u = cross(s, f);
    return mat4x4(
      vec4(s.x, u.x, -f.x, 0),
      vec4(s.y, u.y, -f.y, 0),
      vec4(s.z, u.z, -f.z, 0),
      vec4(
        -(s.x * eye.x + s.y * eye.y + s.z * eye.z),
        -(u.x * eye.x + u.y * eye.y + u.z * eye.z),
        f.x * eye.x + f.y * eye.y + f.z * eye.z,
        1,
      ),
    );
  }

  /// Translation matrix.
  static mat4x4 translation(vec3 t) => mat4x4(
    vec4(1, 0, 0, 0),
    vec4(0, 1, 0, 0),
    vec4(0, 0, 1, 0),
    vec4(t.x, t.y, t.z, 1),
  );

  /// Scaling matrix.
  static mat4x4 scaling(vec3 s) => mat4x4(
    vec4(s.x, 0, 0, 0),
    vec4(0, s.y, 0, 0),
    vec4(0, 0, s.z, 0),
    vec4(0, 0, 0, 1),
  );

  /// Rotation around X axis. [angle] in radians.
  static mat4x4 rotationX(double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    return mat4x4(
      vec4(1, 0, 0, 0),
      vec4(0, c, s, 0),
      vec4(0, -s, c, 0),
      vec4(0, 0, 0, 1),
    );
  }

  /// Rotation around Y axis. [angle] in radians.
  static mat4x4 rotationY(double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    return mat4x4(
      vec4(c, 0, -s, 0),
      vec4(0, 1, 0, 0),
      vec4(s, 0, c, 0),
      vec4(0, 0, 0, 1),
    );
  }

  /// Rotation around Z axis. [angle] in radians.
  static mat4x4 rotationZ(double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    return mat4x4(
      vec4(c, s, 0, 0),
      vec4(-s, c, 0, 0),
      vec4(0, 0, 1, 0),
      vec4(0, 0, 0, 1),
    );
  }

  /// Rotation around an arbitrary [axis] (must be normalized). [angle] in radians.
  static mat4x4 rotationAxisAngle(vec3 axis, double angle) {
    final c = math.cos(angle);
    final s = math.sin(angle);
    final t = 1.0 - c;
    final x = axis.x, y = axis.y, z = axis.z;
    return mat4x4(
      vec4(t * x * x + c, t * x * y + s * z, t * x * z - s * y, 0),
      vec4(t * x * y - s * z, t * y * y + c, t * y * z + s * x, 0),
      vec4(t * x * z + s * y, t * y * z - s * x, t * z * z + c, 0),
      vec4(0, 0, 0, 1),
    );
  }

  /// Compose Translation * Rotation * Scale in one shot.
  static mat4x4 trs(vec3 translation, quat rotation, vec3 scale) {
    // Compute rotation matrix elements from quaternion.
    final x2 = rotation.x + rotation.x;
    final y2 = rotation.y + rotation.y;
    final z2 = rotation.z + rotation.z;
    final xx = rotation.x * x2, xy = rotation.x * y2, xz = rotation.x * z2;
    final yy = rotation.y * y2, yz = rotation.y * z2, zz = rotation.z * z2;
    final wx = rotation.w * x2, wy = rotation.w * y2, wz = rotation.w * z2;

    // Fuse: embed scale into rotation columns, add translation to c3.
    return mat4x4(
      vec4(
        (1.0 - (yy + zz)) * scale.x,
        (xy + wz) * scale.x,
        (xz - wy) * scale.x,
        0,
      ),
      vec4(
        (xy - wz) * scale.y,
        (1.0 - (xx + zz)) * scale.y,
        (yz + wx) * scale.y,
        0,
      ),
      vec4(
        (xz + wy) * scale.z,
        (yz - wx) * scale.z,
        (1.0 - (xx + yy)) * scale.z,
        0,
      ),
      vec4(translation.x, translation.y, translation.z, 1),
    );
  }
}

typedef mat2 = mat2x2;
typedef mat3 = mat3x3;
typedef mat4 = mat4x4;
