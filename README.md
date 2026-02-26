# gm

A simple and fast math library for Dart, inspired by [WGSL](https://www.w3.org/TR/WGSL/) conventions.

## Features

- **Vectors** — `vec2`, `vec3`, `vec4` (float), `vec2i/3i/4i` (int), `vec2u/3u/4u` (uint), `vec2b/3b/4b` (bool)
- **Matrices** — all 9 WGSL types (`mat2x2` through `mat4x4`, including non-square), column-major layout
- **Quaternions** — `quat` with slerp, axis-angle, euler, and matrix conversion
- **Scalars** — `f32`, `i32`, `u32` extension types 
- **WGSL built-in functions** — `dot`, `cross`, `normalize`, `length`, `mix`, `clamp`, `smoothstep`, `reflect`, `sin`, `cos`, `pow`, `sqrt`, `abs`, `sign`, `floor`, `ceil`, `step`, `select`, and more
- **Swizzling** — `v.xy`, `v.zyx`, `v.rgb`, `v.wzyx`

## Usage

```dart
import 'package:gm/gm.dart';

// Vectors
const a = vec3(1, 2, 3);
const b = vec3(4, 5, 6);
final c = a + b;           // vec3(5, 7, 9)
final d = dot(a, b);       // 32.0
final n = normalize(a);    // unit length
final r = cross(a, b);     // perpendicular

// Matrices
final view = mat4x4.lookAt(
  eye: vec3(0, 5, 10),
  target: vec3.zero,
  up: vec3(0, 1, 0),
);
final proj = mat4x4.perspective(
  fovY: radians(60.0),
  aspect: 16 / 9,
  near: 0.1,
  far: 100,
);
final mvp = proj * view;

// Quaternions
final q = quat.fromRotationY(radians(90.0));
final rotated = q.rotate(vec3(1, 0, 0)); // vec3(0, 0, -1)

// WGSL functions work on scalars and vectors
final x = mix(0.0, 10.0, 0.5);           // 5.0
final v = mix(vec3.zero, a, 0.5);        // vec3(0.5, 1.0, 1.5)
final s = smoothstep(0.0, 1.0, 0.5);     // 0.5
final clamped = clamp(vec3(-1, 2, 0.5), vec3.zero, vec3(1, 1, 1));
```

## Benchmark

Compared against [vector_math](https://pub.dev/packages/vector_math) — the
standard Dart math library. Each benchmark uses realistic, non-degenerate data
(varying angles, positions, rotations).

| Benchmark | m | vector_math | Speedup |
|---|---|---|---|
| Vec3 arithmetic | 8.7 us | 39.4 us | **4.5x** |
| Vec3 functions | 43.9 us | 53.8 us | **1.2x** |
| Vec3 batch update | 39.9 us | 28.9 us | 0.7x |
| Mat4 multiply chain | 12.3 us | 21.6 us | **1.8x** |
| Mat4 transform | 6.8 us | 33.5 us | **4.9x** |
| Camera setup | 35.6 us | 88.7 us | **2.5x** |
| Quaternion slerp | 215.5 us | 265.2 us | **1.2x** |
| Quaternion rotate | 11.9 us | 40.6 us | **3.4x** |

m wins **7 out of 8** categories (1.2x-4.9x faster). vector_math wins the
batch update case where its in-place `addScaled` avoids allocations entirely.

### GC pressure

Measured with `dart --verbose-gc`, counting only the `main` isolate.

| Benchmark | m GCs | vm GCs |
|---|---|---|
| Vec3 arithmetic | 2 | 2 |
| Vec3 functions | 8,175 | 3 |
| Vec3 batch update | 9,053 | 1 |
| Mat4 multiply chain | 15 | 2 |
| Mat4 transform | 2 | 2 |
| Camera setup | 9,789 | 5,465 |
| Quaternion slerp | 2,699 | 3,161 |
| Quaternion rotate | 2 | 2 |

Immutable types allocate more intermediates — vec3 functions and batch update
show thousands of young-gen scavenges.

**Design tradeoff**: m uses immutable values (plain `final double` fields, no
`Float32List` backing). This gives the Dart VM more optimization room for
compute-and-discard patterns (transforms, projections, rotations) where m is
2-5x faster with negligible GC. Mutable libraries win tight update loops that
modify the same vector thousands of times per frame.

Run the benchmark yourself:
```
dart benchmark/vs_vector_math.dart
```

