import 'dart:math' as math;

import 'mat.dart';
import 'vec.dart';

/// Euler angle rotation order for [quat.fromEuler] and [quat.toEuler].
enum EulerOrder {
  xyz(0, 1, 2, 1),
  xzy(0, 2, 1, -1),
  yxz(1, 0, 2, -1),
  yzx(1, 2, 0, 1),
  zxy(2, 0, 1, 1),
  zyx(2, 1, 0, -1);

  const EulerOrder(this._i, this._j, this._k, this._sign);
  final int _i, _j, _k, _sign;
}

double _m3At(mat3x3 m, int col, int row) {
  final c = switch (col) {
    0 => m.c0,
    1 => m.c1,
    _ => m.c2,
  };
  return switch (row) {
    0 => c.x,
    1 => c.y,
    _ => c.z,
  };
}

/// Quaternion (x, y, z, w) where w is the scalar part.
final class quat {
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  const quat(this.x, this.y, this.z, this.w);

  static const identity = quat(0, 0, 0, 1);
  static const zero = quat(0, 0, 0, 0);

  final double x, y, z, w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get magnitudeSquared => x * x + y * y + z * z + w * w;

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double get magnitude => math.sqrt(x * x + y * y + z * z + w * w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat get normalized {
    final l = math.sqrt(x * x + y * y + z * z + w * w);
    return l == 0 ? quat.zero : quat(x / l, y / l, z / l, w / l);
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat get conjugate => quat(-x, -y, -z, w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat get inversed {
    final ms = x * x + y * y + z * z + w * w;
    return quat(-x / ms, -y / ms, -z / ms, w / ms);
  }

  /// Hamilton product.
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat operator *(quat o) => quat(
    w * o.x + x * o.w + y * o.z - z * o.y,
    w * o.y - x * o.z + y * o.w + z * o.x,
    w * o.z + x * o.y - y * o.x + z * o.w,
    w * o.w - x * o.x - y * o.y - z * o.z,
  );

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat operator +(quat o) => quat(x + o.x, y + o.y, z + o.z, w + o.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat operator -(quat o) => quat(x - o.x, y - o.y, z - o.z, w - o.w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat operator -() => quat(-x, -y, -z, -w);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  quat scale(double s) => quat(x * s, y * s, z * s, w * s);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double dotWith(quat o) => x * o.x + y * o.y + z * o.z + w * o.w;

  /// Rotates a vec3 by this quaternion: q * v * q⁻¹ (optimized).
  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3 rotate(vec3 v) {
    // t = 2 * cross(q.xyz, v)
    final tx = 2.0 * (y * v.z - z * v.y);
    final ty = 2.0 * (z * v.x - x * v.z);
    final tz = 2.0 * (x * v.y - y * v.x);
    // result = v + w * t + cross(q.xyz, t)
    return vec3(
      v.x + w * tx + (y * tz - z * ty),
      v.y + w * ty + (z * tx - x * tz),
      v.z + w * tz + (x * ty - y * tx),
    );
  }

  /// Converts to a 3x3 rotation matrix.
  mat3x3 toMat3() {
    final x2 = x + x, y2 = y + y, z2 = z + z;
    final xx = x * x2, xy = x * y2, xz = x * z2;
    final yy = y * y2, yz = y * z2, zz = z * z2;
    final wx = w * x2, wy = w * y2, wz = w * z2;
    return mat3x3(
      vec3(1.0 - (yy + zz), xy + wz, xz - wy),
      vec3(xy - wz, 1.0 - (xx + zz), yz + wx),
      vec3(xz + wy, yz - wx, 1.0 - (xx + yy)),
    );
  }

  /// Converts to a 4x4 rotation matrix (translation = 0).
  mat4x4 toMat4() {
    final x2 = x + x, y2 = y + y, z2 = z + z;
    final xx = x * x2, xy = x * y2, xz = x * z2;
    final yy = y * y2, yz = y * z2, zz = z * z2;
    final wx = w * x2, wy = w * y2, wz = w * z2;
    return mat4x4(
      vec4(1.0 - (yy + zz), xy + wz, xz - wy, 0),
      vec4(xy - wz, 1.0 - (xx + zz), yz + wx, 0),
      vec4(xz + wy, yz - wx, 1.0 - (xx + yy), 0),
      vec4(0, 0, 0, 1),
    );
  }

  /// Spherical linear interpolation. Takes the shortest path.
  quat slerp(quat other, double t) {
    var d = x * other.x + y * other.y + z * other.z + w * other.w;
    var ox = other.x, oy = other.y, oz = other.z, ow = other.w;

    // Ensure shortest path.
    if (d < 0.0) {
      d = -d;
      ox = -ox;
      oy = -oy;
      oz = -oz;
      ow = -ow;
    }

    // Fall back to lerp+normalize for near-parallel quaternions.
    if (d > 0.9995) {
      return quat(
        x + (ox - x) * t,
        y + (oy - y) * t,
        z + (oz - z) * t,
        w + (ow - w) * t,
      ).normalized;
    }

    final theta = math.acos(d);
    final sinTheta = math.sin(theta);
    final s0 = math.sin((1.0 - t) * theta) / sinTheta;
    final s1 = math.sin(t * theta) / sinTheta;
    return quat(
      s0 * x + s1 * ox,
      s0 * y + s1 * oy,
      s0 * z + s1 * oz,
      s0 * w + s1 * ow,
    );
  }

  static quat fromAxisAngle(vec3 axis, double angle) {
    final half = angle * 0.5;
    final s = math.sin(half);
    return quat(axis.x * s, axis.y * s, axis.z * s, math.cos(half));
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  static quat fromRotationX(double angle) {
    final half = angle * 0.5;
    return quat(math.sin(half), 0, 0, math.cos(half));
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  static quat fromRotationY(double angle) {
    final half = angle * 0.5;
    return quat(0, math.sin(half), 0, math.cos(half));
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  static quat fromRotationZ(double angle) {
    final half = angle * 0.5;
    return quat(0, 0, math.sin(half), math.cos(half));
  }

  /// Extract rotation quaternion from a pure rotation matrix.
  static quat fromMat3(mat3x3 m) {
    // Shepperd's method — numerically stable for all rotations.
    final trace = m.c0.x + m.c1.y + m.c2.z;
    if (trace > 0.0) {
      final s = math.sqrt(trace + 1.0) * 2.0; // s = 4w
      return quat(
        (m.c1.z - m.c2.y) / s,
        (m.c2.x - m.c0.z) / s,
        (m.c0.y - m.c1.x) / s,
        0.25 * s,
      );
    } else if (m.c0.x > m.c1.y && m.c0.x > m.c2.z) {
      final s = math.sqrt(1.0 + m.c0.x - m.c1.y - m.c2.z) * 2.0; // s = 4x
      return quat(
        0.25 * s,
        (m.c0.y + m.c1.x) / s,
        (m.c2.x + m.c0.z) / s,
        (m.c1.z - m.c2.y) / s,
      );
    } else if (m.c1.y > m.c2.z) {
      final s = math.sqrt(1.0 + m.c1.y - m.c0.x - m.c2.z) * 2.0; // s = 4y
      return quat(
        (m.c0.y + m.c1.x) / s,
        0.25 * s,
        (m.c1.z + m.c2.y) / s,
        (m.c2.x - m.c0.z) / s,
      );
    } else {
      final s = math.sqrt(1.0 + m.c2.z - m.c0.x - m.c1.y) * 2.0; // s = 4z
      return quat(
        (m.c2.x + m.c0.z) / s,
        (m.c1.z + m.c2.y) / s,
        0.25 * s,
        (m.c0.y - m.c1.x) / s,
      );
    }
  }

  /// Creates a quaternion from Euler angles (a, b, c) in the given [order].
  /// Composes Ri(a) * Rj(b) * Rk(c) where i, j, k are the axes of [order].
  static quat fromEuler(double a, double b, double c, EulerOrder order) {
    quat axisQuat(int axis, double angle) => switch (axis) {
      0 => fromRotationX(angle),
      1 => fromRotationY(angle),
      _ => fromRotationZ(angle),
    };
    return axisQuat(order._i, a) *
        axisQuat(order._j, b) *
        axisQuat(order._k, c);
  }

  /// Extracts Euler angles (a, b, c) in the given [order].
  /// Returns a vec3 where x=a (first axis), y=b (second axis), z=c (third axis).
  vec3 toEuler(EulerOrder order) {
    final m = toMat3();
    final i = order._i, j = order._j, k = order._k;
    final s = order._sign.toDouble();

    final sinB = s * _m3At(m, k, i);

    double a, b, c;
    b = math.asin(sinB.clamp(-1.0, 1.0));

    if ((1.0 - sinB.abs()) > 1e-6) {
      // Normal case: M[row, col] → _m3At(m, col, row).
      a = math.atan2(-s * _m3At(m, k, j), _m3At(m, k, k));
      c = math.atan2(-s * _m3At(m, j, i), _m3At(m, i, i));
    } else {
      // Gimbal lock — set c=0 and solve a from remaining elements.
      c = 0.0;
      a = math.atan2(sinB * _m3At(m, i, j), _m3At(m, j, j));
    }

    return vec3(a, b, c);
  }

  @override
  bool operator ==(Object other) =>
      other is quat &&
      x == other.x &&
      y == other.y &&
      z == other.z &&
      w == other.w;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  String get display => 'quat($x, $y, $z, $w)';
}
