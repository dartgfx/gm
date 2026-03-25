# gm

WGSL-style math library for Dart. Vectors, matrices, quaternions, and all the WGSL built-in functions.

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

// Scalar multiply/divide
final scaled = a * 2.0;    // vec3(2, 4, 6)

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

## What's in the box

**Vectors** — `vec2`, `vec3`, `vec4` (float), `vec2i/3i/4i` (int), `vec2u/3u/4u` (uint), `vec2b/3b/4b` (bool). Indexing, swizzling (`v.xy`, `v.zyx`, `v.rgb`), component replacement (`v.withX(5)`).

**Matrices** — all 9 WGSL types (`mat2x2` through `mat4x4`, including non-square), column-major.

**Quaternions** — `quat` with slerp, axis-angle, euler, and matrix conversion.

**Scalars** — `f32`, `i32`, `u32` extension types.

**WGSL built-in functions** — `dot`, `cross`, `normalize`, `length`, `mix`, `clamp`, `smoothstep`, `reflect`, `sin`, `cos`, `pow`, `sqrt`, `abs`, `sign`, `floor`, `ceil`, `step`, `select`, and more.

## Benchmark

Compared against [vector_math](https://pub.dev/packages/vector_math) on Dart 3.11.1, Apple M4 Pro.

### JIT (`dart run`)

| Benchmark | gm | vector_math | Speedup |
|---|---|---|---|
| Vec3 arithmetic | 8.7 us | 43.2 us | **5.0x** |
| Vec3 functions | 21.6 us | 58.7 us | **2.7x** |
| Vec3 batch update | 38.5 us | 27.9 us | 0.7x |
| Mat4 multiply chain | 12.1 us | 21.2 us | **1.8x** |
| Mat4 transform | 6.7 us | 33.2 us | **5.0x** |
| Camera setup | 10.9 us | 87.2 us | **8.0x** |
| Quaternion slerp | 166.2 us | 261.2 us | **1.6x** |
| Quaternion rotate | 11.9 us | 39.6 us | **3.3x** |

### AOT (`dart compile exe`)

| Benchmark | gm | vector_math | Speedup |
|---|---|---|---|
| Vec3 arithmetic | 8.7 us | 42.4 us | **4.9x** |
| Vec3 functions | 16.4 us | 55.3 us | **3.4x** |
| Vec3 batch update | 39.7 us | 25.3 us | 0.6x |
| Mat4 multiply chain | 3.6 us | 20.6 us | **5.7x** |
| Mat4 transform | 7.0 us | 50.8 us | **7.3x** |
| Camera setup | 5.8 us | 87.0 us | **15.0x** |
| Quaternion slerp | 176.7 us | 216.3 us | **1.2x** |
| Quaternion rotate | 14.1 us | 45.9 us | **3.3x** |

gm wins 7 out of 8 in both modes. AOT benefits more from inline pragmas. vector_math wins batch update where its in-place `addScaled` avoids allocations.

### GC pressure

Measured with `dart --verbose-gc`, main isolate only.

| Benchmark | gm GCs | vm GCs |
|---|---|---|
| Vec3 arithmetic | 1 | 0 |
| Vec3 functions | 0 | 0 |
| Vec3 batch update | 219 | 0 |
| Mat4 multiply chain | 0 | 0 |
| Mat4 transform | 0 | 0 |
| Camera setup | 143 | 0 |
| Quaternion slerp | 169 | 0 |
| Quaternion rotate | 1 | 0 |

gm uses immutable values (plain `final double` fields, no `Float32List` backing) with inline pragmas that let the Dart VM scalar-replace intermediates. Batch update and camera setup still allocate, the rest produce zero GC.

```
dart benchmark/vs_vector_math.dart
```
