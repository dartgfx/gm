import 'dart:math' as math;

import 'vec.dart';

/// Component-wise unary for f32/vec
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T _mapF<T>(T x, double Function(double) op) => switch (x) {
      double v => op(v) as T,
      vec3 v => vec3(op(v.x), op(v.y), op(v.z)) as T,
      vec2 v => vec2(op(v.x), op(v.y)) as T,
      vec4 v => vec4(op(v.x), op(v.y), op(v.z), op(v.w)) as T,
      _ => throw UnsupportedError('Unsupported type: ${x.runtimeType}'),
    };

/// Component-wise binary for f32/vec.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T _map2F<T>(T a, T b, double Function(double, double) op) => switch (a) {
      double va => op(va, b as double) as T,
      vec3 va =>
        vec3(op(va.x, (b as vec3).x), op(va.y, b.y), op(va.z, b.z)) as T,
      vec2 va => vec2(op(va.x, (b as vec2).x), op(va.y, b.y)) as T,
      vec4 va => vec4(op(va.x, (b as vec4).x), op(va.y, b.y), op(va.z, b.z),
          op(va.w, b.w)) as T,
      _ => throw UnsupportedError('Unsupported type: ${a.runtimeType}'),
    };

/// Component-wise unary, handles float/int scalars and all vector types.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T _mapN<T>(T x, double Function(double) fOp, int Function(int) iOp) =>
    switch (x) {
      double v => fOp(v) as T,
      int v => iOp(v) as T,
      vec3 v => vec3(fOp(v.x), fOp(v.y), fOp(v.z)) as T,
      vec2 v => vec2(fOp(v.x), fOp(v.y)) as T,
      vec4 v => vec4(fOp(v.x), fOp(v.y), fOp(v.z), fOp(v.w)) as T,
      vec3i v => vec3i(iOp(v.x), iOp(v.y), iOp(v.z)) as T,
      vec2i v => vec2i(iOp(v.x), iOp(v.y)) as T,
      vec4i v => vec4i(iOp(v.x), iOp(v.y), iOp(v.z), iOp(v.w)) as T,
      vec3u v => vec3u(iOp(v.x), iOp(v.y), iOp(v.z)) as T,
      vec2u v => vec2u(iOp(v.x), iOp(v.y)) as T,
      vec4u v => vec4u(iOp(v.x), iOp(v.y), iOp(v.z), iOp(v.w)) as T,
      _ => throw UnsupportedError('Unsupported type: ${x.runtimeType}'),
    };

/// Component-wise binary, handles float/int scalars and all vector types.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T _map2N<T>(
  T a,
  T b,
  double Function(double, double) fOp,
  int Function(int, int) iOp,
) =>
    switch (a) {
      double va => fOp(va, b as double) as T,
      int va => iOp(va, b as int) as T,
      vec3 va =>
        vec3(fOp(va.x, (b as vec3).x), fOp(va.y, b.y), fOp(va.z, b.z)) as T,
      vec2 va => vec2(fOp(va.x, (b as vec2).x), fOp(va.y, b.y)) as T,
      vec4 va => vec4(
          fOp(va.x, (b as vec4).x),
          fOp(va.y, b.y),
          fOp(va.z, b.z),
          fOp(va.w, b.w),
        ) as T,
      vec3i va =>
        vec3i(iOp(va.x, (b as vec3i).x), iOp(va.y, b.y), iOp(va.z, b.z)) as T,
      vec2i va => vec2i(iOp(va.x, (b as vec2i).x), iOp(va.y, b.y)) as T,
      vec4i va => vec4i(
          iOp(va.x, (b as vec4i).x),
          iOp(va.y, b.y),
          iOp(va.z, b.z),
          iOp(va.w, b.w),
        ) as T,
      vec3u va =>
        vec3u(iOp(va.x, (b as vec3u).x), iOp(va.y, b.y), iOp(va.z, b.z)) as T,
      vec2u va => vec2u(iOp(va.x, (b as vec2u).x), iOp(va.y, b.y)) as T,
      vec4u va => vec4u(
          iOp(va.x, (b as vec4u).x),
          iOp(va.y, b.y),
          iOp(va.z, b.z),
          iOp(va.w, b.w),
        ) as T,
      _ => throw UnsupportedError('Unsupported type: ${a.runtimeType}'),
    };

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T max<T>(T a, T b) => _map2N(a, b, math.max, math.max);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T min<T>(T a, T b) => _map2N(a, b, math.min, math.min);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T abs<T>(T x) => _mapN(x, (v) => v.abs(), (v) => v.abs());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T sign<T>(T x) => _mapN(
      x,
      (v) => v > 0 ? 1.0 : (v < 0 ? -1.0 : 0.0),
      (v) => v > 0 ? 1 : (v < 0 ? -1 : 0),
    );

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T clamp<T>(T x, T low, T high) => min(max(x, low), high);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T saturate<T>(T x) => switch (x) {
      double v => (v < 0.0 ? 0.0 : (v > 1.0 ? 1.0 : v)) as T,
      vec3 v => vec3(
          v.x < 0.0 ? 0.0 : (v.x > 1.0 ? 1.0 : v.x),
          v.y < 0.0 ? 0.0 : (v.y > 1.0 ? 1.0 : v.y),
          v.z < 0.0 ? 0.0 : (v.z > 1.0 ? 1.0 : v.z),
        ) as T,
      vec2 v => vec2(
          v.x < 0.0 ? 0.0 : (v.x > 1.0 ? 1.0 : v.x),
          v.y < 0.0 ? 0.0 : (v.y > 1.0 ? 1.0 : v.y),
        ) as T,
      vec4 v => vec4(
          v.x < 0.0 ? 0.0 : (v.x > 1.0 ? 1.0 : v.x),
          v.y < 0.0 ? 0.0 : (v.y > 1.0 ? 1.0 : v.y),
          v.z < 0.0 ? 0.0 : (v.z > 1.0 ? 1.0 : v.z),
          v.w < 0.0 ? 0.0 : (v.w > 1.0 ? 1.0 : v.w),
        ) as T,
      _ =>
        throw UnsupportedError('saturate: unsupported type ${x.runtimeType}'),
    };

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T step<T>(T edge, T x) => _map2F(edge, x, (e, v) => v < e ? 0.0 : 1.0);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T smoothstep<T>(T edge0, T edge1, T x) => switch (x) {
      double x => _ssScalar(x, edge0 as double, edge1 as double) as T,
      vec3 x => x.smoothstepWith(edge0 as vec3, edge1 as vec3) as T,
      vec2 x => x.smoothstepWith(edge0 as vec2, edge1 as vec2) as T,
      vec4 x => x.smoothstepWith(edge0 as vec4, edge1 as vec4) as T,
      _ =>
        throw UnsupportedError('smoothstep: unsupported type ${x.runtimeType}'),
    };

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double _ssScalar(double v, double e0, double e1) {
  var t = (v - e0) / (e1 - e0);
  t = t < 0.0 ? 0.0 : (t > 1.0 ? 1.0 : t);
  return t * t * (3.0 - 2.0 * t);
}

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T floor<T>(T x) => _mapF(x, (v) => v.floorToDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T ceil<T>(T x) => _mapF(x, (v) => v.ceilToDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T round<T>(T x) => _mapF(x, (v) => v.roundToDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T trunc<T>(T x) => _mapF(x, (v) => v.truncateToDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T fract<T>(T x) => _mapF(x, (v) => v - v.floorToDouble());

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T sqrt<T>(T x) => _mapF(x, math.sqrt);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T inverseSqrt<T>(T x) => _mapF(x, (v) => 1.0 / math.sqrt(v));
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T pow<T>(T x, T y) => _map2F(x, y, (a, b) => math.pow(a, b).toDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T exp<T>(T x) => _mapF(x, math.exp);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T exp2<T>(T x) => _mapF(x, (v) => math.pow(2, v).toDouble());
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T log<T>(T x) => _mapF(x, math.log);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T log2<T>(T x) => _mapF(x, (v) => math.log(v) / math.ln2);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T sin<T>(T x) => _mapF(x, math.sin);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T cos<T>(T x) => _mapF(x, math.cos);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T tan<T>(T x) => _mapF(x, math.tan);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T asin<T>(T x) => _mapF(x, math.asin);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T acos<T>(T x) => _mapF(x, math.acos);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T atan<T>(T x) => _mapF(x, math.atan);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double atan2(double y, double x) => math.atan2(y, x);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T radians<T>(T x) => _mapF(x, (v) => v * math.pi / 180.0);
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T degrees<T>(T x) => _mapF(x, (v) => v * 180.0 / math.pi);

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T mix<T>(T a, T b, dynamic t) {
  if (a is double) return (a * (1.0 - (t as double)) + (b as double) * t) as T;
  if (t is double) {
    return switch (a) {
      vec3 a => a.mixWith(b as vec3, t) as T,
      vec2 a => a.mixWith(b as vec2, t) as T,
      vec4 a => a.mixWith(b as vec4, t) as T,
      _ => throw UnsupportedError('mix: unsupported type ${a.runtimeType}'),
    };
  }
  return switch (a) {
    vec3 a => a.mixWithVec(b as vec3, t as vec3) as T,
    vec2 a => a.mixWithVec(b as vec2, t as vec2) as T,
    vec4 a => a.mixWithVec(b as vec4, t as vec4) as T,
    _ => throw UnsupportedError('mix: unsupported type ${a.runtimeType}'),
  };
}

/// Dot product.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double dot(vecf a, vecf b) => switch (a) {
      vec3 a => a.x * (b as vec3).x + a.y * b.y + a.z * b.z,
      vec2 a => a.x * (b as vec2).x + a.y * b.y,
      vec4 a => a.x * (b as vec4).x + a.y * b.y + a.z * b.z + a.w * b.w,
    };

/// Cross product.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vec3 cross(vec3 a, vec3 b) =>
    vec3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);

/// Vector length.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double length(vecf v) => switch (v) {
      vec3 v => v.length,
      vec2 v => v.length,
      vec4 v => v.length,
    };

/// Distance between two points.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double distance(vecf a, vecf b) => switch (a) {
      vec3 a => a.distanceTo(b as vec3),
      vec2 a => a.distanceTo(b as vec2),
      vec4 a => a.distanceTo(b as vec4),
    };

/// Normalize to unit length.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T normalize<T extends vecf>(T v) => switch (v) {
      vec3 v => v.normalized as T,
      vec2 v => v.normalized as T,
      vec4 v => v.normalized as T,
    };

/// Reflect incident vector.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T reflect<T extends vecf>(T i, T n) => switch (i) {
      vec3 i => i.reflectOn(n as vec3) as T,
      vec2 i => i.reflectOn(n as vec2) as T,
      vec4 i => i.reflectOn(n as vec4) as T,
    };

/// Face forward.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T faceForward<T extends vecf>(T e1, T e2, T e3) {
  final d = dot(e2, e3);
  if (d < 0) return e1;
  return switch (e1) {
    vec3 v => -v as T,
    vec2 v => -v as T,
    vec4 v => -v as T,
  };
}

/// Fused multiply-add: `e1 * e2 + e3`.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T fma<T>(T e1, T e2, T e3) => switch (e1) {
      double e1 => (e1 * (e2 as double) + (e3 as double)) as T,
      vec2 e1 => vec2(
          e1.x * (e2 as vec2).x + (e3 as vec2).x,
          e1.y * e2.y + e3.y,
        ) as T,
      vec3 e1 => vec3(
          e1.x * (e2 as vec3).x + (e3 as vec3).x,
          e1.y * e2.y + e3.y,
          e1.z * e2.z + e3.z,
        ) as T,
      vec4 e1 => vec4(
          e1.x * (e2 as vec4).x + (e3 as vec4).x,
          e1.y * e2.y + e3.y,
          e1.z * e2.z + e3.z,
          e1.w * e2.w + e3.w,
        ) as T,
      _ => throw UnsupportedError('fma: unsupported type ${e1.runtimeType}'),
    };

/// True if all components are true.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
bool all(vecb v) => v.all;

/// True if any component is true.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
bool any(vecb v) => v.any;

/// Component-wise select.
///
/// When [cond] is `bool`, returns [f] if false, [t] if true (scalar ternary).
/// When [cond] is `vecb`, returns component-wise selection.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
T select<T>(T f, T t, dynamic cond) {
  if (cond is bool) return cond ? t : f;
  return switch (cond) {
    vec2b c => switch (f) {
        vec2 f =>
          vec2(c.x ? (t as vec2).x : f.x, c.y ? (t as vec2).y : f.y) as T,
        vec2i f =>
          vec2i(c.x ? (t as vec2i).x : f.x, c.y ? (t as vec2i).y : f.y) as T,
        vec2u f =>
          vec2u(c.x ? (t as vec2u).x : f.x, c.y ? (t as vec2u).y : f.y) as T,
        _ =>
          throw UnsupportedError('select: unsupported type ${f.runtimeType}'),
      },
    vec3b c => switch (f) {
        vec3 f => vec3(
            c.x ? (t as vec3).x : f.x,
            c.y ? (t as vec3).y : f.y,
            c.z ? (t as vec3).z : f.z,
          ) as T,
        vec3i f => vec3i(
            c.x ? (t as vec3i).x : f.x,
            c.y ? (t as vec3i).y : f.y,
            c.z ? (t as vec3i).z : f.z,
          ) as T,
        vec3u f => vec3u(
            c.x ? (t as vec3u).x : f.x,
            c.y ? (t as vec3u).y : f.y,
            c.z ? (t as vec3u).z : f.z,
          ) as T,
        _ =>
          throw UnsupportedError('select: unsupported type ${f.runtimeType}'),
      },
    vec4b c => switch (f) {
        vec4 f => vec4(
            c.x ? (t as vec4).x : f.x,
            c.y ? (t as vec4).y : f.y,
            c.z ? (t as vec4).z : f.z,
            c.w ? (t as vec4).w : f.w,
          ) as T,
        vec4i f => vec4i(
            c.x ? (t as vec4i).x : f.x,
            c.y ? (t as vec4i).y : f.y,
            c.z ? (t as vec4i).z : f.z,
            c.w ? (t as vec4i).w : f.w,
          ) as T,
        vec4u f => vec4u(
            c.x ? (t as vec4u).x : f.x,
            c.y ? (t as vec4u).y : f.y,
            c.z ? (t as vec4u).z : f.z,
            c.w ? (t as vec4u).w : f.w,
          ) as T,
        _ =>
          throw UnsupportedError('select: unsupported type ${f.runtimeType}'),
      },
    _ => throw UnsupportedError('select: cond must be bool or vecb'),
  };
}

/// Component-wise less-than.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb lessThan(vec a, vec b) => switch (a) {
      vec2 a => vec2b((a.x < (b as vec2).x), a.y < b.y),
      vec3 a => vec3b((a.x < (b as vec3).x), a.y < b.y, a.z < b.z),
      vec4 a => vec4b((a.x < (b as vec4).x), a.y < b.y, a.z < b.z, a.w < b.w),
      vec2i a => vec2b(a.x < (b as vec2i).x, a.y < b.y),
      vec3i a => vec3b(a.x < (b as vec3i).x, a.y < b.y, a.z < b.z),
      vec4i a => vec4b(a.x < (b as vec4i).x, a.y < b.y, a.z < b.z, a.w < b.w),
      vec2u a => vec2b(a.x < (b as vec2u).x, a.y < b.y),
      vec3u a => vec3b(a.x < (b as vec3u).x, a.y < b.y, a.z < b.z),
      vec4u a => vec4b(a.x < (b as vec4u).x, a.y < b.y, a.z < b.z, a.w < b.w),
      _ =>
        throw UnsupportedError('lessThan: unsupported type ${a.runtimeType}'),
    };

/// Component-wise less-than-or-equal.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb lessThanEqual(vec a, vec b) => switch (a) {
      vec2 a => vec2b(a.x <= (b as vec2).x, a.y <= b.y),
      vec3 a => vec3b(a.x <= (b as vec3).x, a.y <= b.y, a.z <= b.z),
      vec4 a => vec4b(a.x <= (b as vec4).x, a.y <= b.y, a.z <= b.z, a.w <= b.w),
      vec2i a => vec2b(a.x <= (b as vec2i).x, a.y <= b.y),
      vec3i a => vec3b(a.x <= (b as vec3i).x, a.y <= b.y, a.z <= b.z),
      vec4i a =>
        vec4b(a.x <= (b as vec4i).x, a.y <= b.y, a.z <= b.z, a.w <= b.w),
      vec2u a => vec2b(a.x <= (b as vec2u).x, a.y <= b.y),
      vec3u a => vec3b(a.x <= (b as vec3u).x, a.y <= b.y, a.z <= b.z),
      vec4u a =>
        vec4b(a.x <= (b as vec4u).x, a.y <= b.y, a.z <= b.z, a.w <= b.w),
      _ => throw UnsupportedError(
          'lessThanEqual: unsupported type ${a.runtimeType}'),
    };

/// Component-wise greater-than.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb greaterThan(vec a, vec b) => switch (a) {
      vec2 a => vec2b(a.x > (b as vec2).x, a.y > b.y),
      vec3 a => vec3b(a.x > (b as vec3).x, a.y > b.y, a.z > b.z),
      vec4 a => vec4b(a.x > (b as vec4).x, a.y > b.y, a.z > b.z, a.w > b.w),
      vec2i a => vec2b(a.x > (b as vec2i).x, a.y > b.y),
      vec3i a => vec3b(a.x > (b as vec3i).x, a.y > b.y, a.z > b.z),
      vec4i a => vec4b(a.x > (b as vec4i).x, a.y > b.y, a.z > b.z, a.w > b.w),
      vec2u a => vec2b(a.x > (b as vec2u).x, a.y > b.y),
      vec3u a => vec3b(a.x > (b as vec3u).x, a.y > b.y, a.z > b.z),
      vec4u a => vec4b(a.x > (b as vec4u).x, a.y > b.y, a.z > b.z, a.w > b.w),
      _ => throw UnsupportedError(
          'greaterThan: unsupported type ${a.runtimeType}'),
    };

/// Component-wise greater-than-or-equal.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb greaterThanEqual(vec a, vec b) => switch (a) {
      vec2 a => vec2b(a.x >= (b as vec2).x, a.y >= b.y),
      vec3 a => vec3b(a.x >= (b as vec3).x, a.y >= b.y, a.z >= b.z),
      vec4 a => vec4b(a.x >= (b as vec4).x, a.y >= b.y, a.z >= b.z, a.w >= b.w),
      vec2i a => vec2b(a.x >= (b as vec2i).x, a.y >= b.y),
      vec3i a => vec3b(a.x >= (b as vec3i).x, a.y >= b.y, a.z >= b.z),
      vec4i a =>
        vec4b(a.x >= (b as vec4i).x, a.y >= b.y, a.z >= b.z, a.w >= b.w),
      vec2u a => vec2b(a.x >= (b as vec2u).x, a.y >= b.y),
      vec3u a => vec3b(a.x >= (b as vec3u).x, a.y >= b.y, a.z >= b.z),
      vec4u a =>
        vec4b(a.x >= (b as vec4u).x, a.y >= b.y, a.z >= b.z, a.w >= b.w),
      _ => throw UnsupportedError(
          'greaterThanEqual: unsupported type ${a.runtimeType}',
        ),
    };

/// Component-wise equality.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb equal(vec a, vec b) => switch (a) {
      vec2 a => vec2b(a.x == (b as vec2).x, a.y == b.y),
      vec3 a => vec3b(a.x == (b as vec3).x, a.y == b.y, a.z == b.z),
      vec4 a => vec4b(a.x == (b as vec4).x, a.y == b.y, a.z == b.z, a.w == b.w),
      vec2i a => vec2b(a.x == (b as vec2i).x, a.y == b.y),
      vec3i a => vec3b(a.x == (b as vec3i).x, a.y == b.y, a.z == b.z),
      vec4i a =>
        vec4b(a.x == (b as vec4i).x, a.y == b.y, a.z == b.z, a.w == b.w),
      vec2u a => vec2b(a.x == (b as vec2u).x, a.y == b.y),
      vec3u a => vec3b(a.x == (b as vec3u).x, a.y == b.y, a.z == b.z),
      vec4u a =>
        vec4b(a.x == (b as vec4u).x, a.y == b.y, a.z == b.z, a.w == b.w),
      vec2b a => vec2b(a.x == (b as vec2b).x, a.y == b.y),
      vec3b a => vec3b(a.x == (b as vec3b).x, a.y == b.y, a.z == b.z),
      vec4b a =>
        vec4b(a.x == (b as vec4b).x, a.y == b.y, a.z == b.z, a.w == b.w),
    };

/// Component-wise inequality.
@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
vecb notEqual(vec a, vec b) => switch (a) {
      vec2 a => vec2b(a.x != (b as vec2).x, a.y != b.y),
      vec3 a => vec3b(a.x != (b as vec3).x, a.y != b.y, a.z != b.z),
      vec4 a => vec4b(a.x != (b as vec4).x, a.y != b.y, a.z != b.z, a.w != b.w),
      vec2i a => vec2b(a.x != (b as vec2i).x, a.y != b.y),
      vec3i a => vec3b(a.x != (b as vec3i).x, a.y != b.y, a.z != b.z),
      vec4i a =>
        vec4b(a.x != (b as vec4i).x, a.y != b.y, a.z != b.z, a.w != b.w),
      vec2u a => vec2b(a.x != (b as vec2u).x, a.y != b.y),
      vec3u a => vec3b(a.x != (b as vec3u).x, a.y != b.y, a.z != b.z),
      vec4u a =>
        vec4b(a.x != (b as vec4u).x, a.y != b.y, a.z != b.z, a.w != b.w),
      vec2b a => vec2b(a.x != (b as vec2b).x, a.y != b.y),
      vec3b a => vec3b(a.x != (b as vec3b).x, a.y != b.y, a.z != b.z),
      vec4b a =>
        vec4b(a.x != (b as vec4b).x, a.y != b.y, a.z != b.z, a.w != b.w),
    };
