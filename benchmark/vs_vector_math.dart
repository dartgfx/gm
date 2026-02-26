// ignore_for_file: avoid_print, unused_local_variable

import 'dart:math' as math;

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:gm/gm.dart' as m;
import 'package:vector_math/vector_math.dart' as vm;

// =============================================================================
// Helpers — build realistic, non-degenerate input data
// =============================================================================

m.vec3 _mVec3(int i) => m.vec3(
  math.sin(i * 0.7) * 10.0,
  math.cos(i * 1.3) * 10.0,
  math.sin(i * 2.1 + 1.0) * 10.0,
);

vm.Vector3 _vmVec3(int i) => vm.Vector3(
  math.sin(i * 0.7) * 10.0,
  math.cos(i * 1.3) * 10.0,
  math.sin(i * 2.1 + 1.0) * 10.0,
);

m.vec3 _mNormal(int i) {
  final v = _mVec3(i);
  return v.normalized;
}

vm.Vector3 _vmNormal(int i) {
  final v = _vmVec3(i);
  return v.normalized();
}

m.mat4x4 _mMat(int i) {
  final angle = 0.3 + i * 0.17;
  final c = math.cos(angle), s = math.sin(angle);
  final tx = 1.0 + i * 0.5, ty = 2.0 - i * 0.3, tz = i * 0.7;
  return m.mat4x4(
    m.vec4(c, 0, -s, 0),
    m.vec4(0, 1, 0, 0),
    m.vec4(s, 0, c, 0),
    m.vec4(tx, ty, tz, 1),
  );
}

vm.Matrix4 _vmMat(int i) {
  final angle = 0.3 + i * 0.17;
  final tx = 1.0 + i * 0.5, ty = 2.0 - i * 0.3, tz = i * 0.7;
  return vm.Matrix4.rotationY(angle)..setTranslation(vm.Vector3(tx, ty, tz));
}

m.quat _mQuat(int i) {
  final axis = _mNormal(i);
  final angle = i * 0.37;
  return m.quat.fromAxisAngle(axis, angle);
}

vm.Quaternion _vmQuat(int i) {
  final axis = _vmNormal(i);
  final angle = i * 0.37;
  return vm.Quaternion.axisAngle(axis, angle);
}

const _n = 1000;

/// Manual slerp for vector_math (it doesn't provide one).
vm.Quaternion _vmSlerp(vm.Quaternion a, vm.Quaternion b, double t) {
  var d = a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
  var ox = b.x, oy = b.y, oz = b.z, ow = b.w;
  if (d < 0.0) {
    d = -d;
    ox = -ox;
    oy = -oy;
    oz = -oz;
    ow = -ow;
  }
  if (d > 0.9995) {
    final r = vm.Quaternion(
      a.x + (ox - a.x) * t,
      a.y + (oy - a.y) * t,
      a.z + (oz - a.z) * t,
      a.w + (ow - a.w) * t,
    );
    r.normalize();
    return r;
  }
  final theta = math.acos(d);
  final sinTheta = math.sin(theta);
  final s0 = math.sin((1.0 - t) * theta) / sinTheta;
  final s1 = math.sin(t * theta) / sinTheta;
  return vm.Quaternion(
    s0 * a.x + s1 * ox,
    s0 * a.y + s1 * oy,
    s0 * a.z + s1 * oz,
    s0 * a.w + s1 * ow,
  );
}

// =============================================================================
// 1. Vec3 arithmetic — add, scale, negate
// =============================================================================

class Vec3ArithM extends BenchmarkBase {
  Vec3ArithM() : super('Vec3Arith.m');

  late List<m.vec3> a, b;
  double _sink = 0;

  @override
  void setup() {
    a = List.generate(_n, (i) => _mVec3(i));
    b = List.generate(_n, (i) => _mVec3(i + _n));
  }

  @override
  void run() {
    final s = m.vec3(2.5);
    for (var i = 0; i < _n; i++) {
      final r = -(a[i] + b[i]) * s;
      _sink += r.x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class Vec3ArithVM extends BenchmarkBase {
  Vec3ArithVM() : super('Vec3Arith.vector_math');

  late List<vm.Vector3> a, b;
  late vm.Vector3 _scratch;
  double _sink = 0;

  @override
  void setup() {
    a = List.generate(_n, (i) => _vmVec3(i));
    b = List.generate(_n, (i) => _vmVec3(i + _n));
    _scratch = vm.Vector3.zero();
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      _scratch.setFrom(a[i]);
      _scratch.add(b[i]);
      _scratch.negate();
      _scratch.scale(2.5);
      _sink += _scratch.x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 2. Vec3 functions — normalize, dot, cross, length, reflect
// =============================================================================

class Vec3FuncsM extends BenchmarkBase {
  Vec3FuncsM() : super('Vec3Funcs.m');

  late List<m.vec3> vecs;
  late List<m.vec3> normals;
  double _sink = 0;

  @override
  void setup() {
    vecs = List.generate(_n, (i) => _mVec3(i));
    normals = List.generate(_n, (i) => _mNormal(i + _n));
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final v = vecs[i];
      final n = normals[i];
      final norm = v.normalized;
      final d = v.dotWith(n);
      final c = m.cross(v, n);
      final l = v.magnitude;
      final r = v.reflectOn(n);
      _sink += norm.x + d + c.y + l + r.z;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class Vec3FuncsVM extends BenchmarkBase {
  Vec3FuncsVM() : super('Vec3Funcs.vector_math');

  late List<vm.Vector3> vecs;
  late List<vm.Vector3> normals;
  late vm.Vector3 _scratch;
  late vm.Vector3 _crossOut;
  double _sink = 0;

  @override
  void setup() {
    vecs = List.generate(_n, (i) => _vmVec3(i));
    normals = List.generate(_n, (i) => _vmNormal(i + _n));
    _scratch = vm.Vector3.zero();
    _crossOut = vm.Vector3.zero();
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final v = vecs[i];
      final n = normals[i];
      _scratch.setFrom(v);
      _scratch.normalize();
      final normX = _scratch.x;
      final d = v.dot(n);
      v.crossInto(n, _crossOut);
      final crossY = _crossOut.y;
      final l = v.length;
      _scratch.setFrom(v);
      _scratch.reflect(n);
      _sink += normX + d + crossY + l + _scratch.z;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 3. Vec3 batch update — position += velocity * dt (particle sim)
// =============================================================================

class Vec3BatchM extends BenchmarkBase {
  Vec3BatchM() : super('Vec3Batch.m');

  late List<m.vec3> pos, vel;
  double _sink = 0;

  @override
  void setup() {
    pos = List.generate(_n, (i) => _mVec3(i));
    vel = List.generate(_n, (i) => _mVec3(i + _n));
  }

  @override
  void run() {
    final dt = m.vec3(0.016);
    for (var i = 0; i < _n; i++) {
      pos[i] = m.fma(vel[i], dt, pos[i]);
      _sink += pos[i].x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class Vec3BatchVM extends BenchmarkBase {
  Vec3BatchVM() : super('Vec3Batch.vector_math');

  late List<vm.Vector3> pos, vel;
  double _sink = 0;

  @override
  void setup() {
    pos = List.generate(_n, (i) => _vmVec3(i));
    vel = List.generate(_n, (i) => _vmVec3(i + _n));
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      pos[i].addScaled(vel[i], 0.016);
      _sink += pos[i].x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 4. Mat4 multiply chain — 100 bones: inverseBind * jointWorld * skinRoot
// =============================================================================

class Mat4ChainM extends BenchmarkBase {
  Mat4ChainM() : super('Mat4Chain.m');

  late List<m.mat4x4> inverseBind, jointWorld;
  late m.mat4x4 skinRoot;
  double _sink = 0;

  @override
  void setup() {
    inverseBind = List.generate(100, (i) => _mMat(i));
    jointWorld = List.generate(100, (i) => _mMat(i + 100));
    skinRoot = _mMat(200);
  }

  @override
  void run() {
    for (var i = 0; i < 100; i++) {
      final r = inverseBind[i] * jointWorld[i] * skinRoot;
      _sink += r.c3.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class Mat4ChainVM extends BenchmarkBase {
  Mat4ChainVM() : super('Mat4Chain.vector_math');

  late List<vm.Matrix4> inverseBind, jointWorld;
  late vm.Matrix4 skinRoot;
  late vm.Matrix4 _scratch;
  double _sink = 0;

  @override
  void setup() {
    inverseBind = List.generate(100, (i) => _vmMat(i));
    jointWorld = List.generate(100, (i) => _vmMat(i + 100));
    skinRoot = _vmMat(200);
    _scratch = vm.Matrix4.zero();
  }

  @override
  void run() {
    for (var i = 0; i < 100; i++) {
      _scratch.setFrom(inverseBind[i]);
      _scratch.multiply(jointWorld[i]);
      _scratch.multiply(skinRoot);
      _sink += _scratch.entry(3, 3);
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 5. Mat4 transform — MVP * position for 1000 vertices
// =============================================================================

class Mat4TransformM extends BenchmarkBase {
  Mat4TransformM() : super('Mat4Transform.m');

  late m.mat4x4 mvp;
  late List<m.vec4> positions;
  double _sink = 0;

  @override
  void setup() {
    mvp = _mMat(0) * _mMat(1) * _mMat(2);
    positions = List.generate(
      _n,
      (i) => m.vec4(_mVec3(i).x, _mVec3(i).y, _mVec3(i).z, 1),
    );
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final r = mvp.transform(positions[i]);
      _sink += r.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class Mat4TransformVM extends BenchmarkBase {
  Mat4TransformVM() : super('Mat4Transform.vector_math');

  late vm.Matrix4 mvp;
  late List<vm.Vector4> positions;
  late vm.Vector4 _scratch;
  double _sink = 0;

  @override
  void setup() {
    final m0 = _vmMat(0);
    final m1 = _vmMat(1);
    final m2 = _vmMat(2);
    mvp = m0.multiplied(m1)..multiply(m2);
    positions = List.generate(
      _n,
      (i) => vm.Vector4(
        _vmVec3(i).x,
        _vmVec3(i).y,
        _vmVec3(i).z,
        1,
      ),
    );
    _scratch = vm.Vector4.zero();
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      _scratch.setFrom(positions[i]);
      mvp.transform(_scratch);
      _sink += _scratch.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 6. Camera setup — lookAt + perspective, 100 iterations
// =============================================================================

class CameraSetupM extends BenchmarkBase {
  CameraSetupM() : super('CameraSetup.m');

  late List<m.vec3> eyes, targets;
  double _sink = 0;

  @override
  void setup() {
    eyes = List.generate(100, (i) => _mVec3(i));
    targets = List.generate(100, (i) => _mVec3(i + 100));
  }

  @override
  void run() {
    for (var i = 0; i < 100; i++) {
      final view = m.mat4x4.lookAt(
        eye: eyes[i],
        target: targets[i],
        up: m.vec3(0, 1, 0),
      );
      final proj = m.mat4x4.perspective(
        fovY: 1.0472, // 60 degrees
        aspect: 16.0 / 9.0,
        near: 0.1,
        far: 1000.0,
      );
      final vp = proj * view;
      _sink += vp.c3.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class CameraSetupVM extends BenchmarkBase {
  CameraSetupVM() : super('CameraSetup.vector_math');

  late List<vm.Vector3> eyes, targets;
  double _sink = 0;

  @override
  void setup() {
    eyes = List.generate(100, (i) => _vmVec3(i));
    targets = List.generate(100, (i) => _vmVec3(i + 100));
  }

  @override
  void run() {
    for (var i = 0; i < 100; i++) {
      final view = vm.makeViewMatrix(eyes[i], targets[i], vm.Vector3(0, 1, 0));
      final proj = vm.makePerspectiveMatrix(
        1.0472, // 60 degrees
        16.0 / 9.0,
        0.1,
        1000.0,
      );
      proj.multiply(view);
      _sink += proj.entry(3, 3);
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 7. Quaternion slerp — interpolate 1000 pairs
// =============================================================================

class QuatSlerpM extends BenchmarkBase {
  QuatSlerpM() : super('QuatSlerp.m');

  late List<m.quat> a, b;
  double _sink = 0;

  @override
  void setup() {
    a = List.generate(_n, (i) => _mQuat(i));
    b = List.generate(_n, (i) => _mQuat(i + _n));
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final r = a[i].slerp(b[i], 0.5);
      _sink += r.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class QuatSlerpVM extends BenchmarkBase {
  QuatSlerpVM() : super('QuatSlerp.vector_math');

  late List<vm.Quaternion> a, b;
  double _sink = 0;

  @override
  void setup() {
    a = List.generate(_n, (i) => _vmQuat(i));
    b = List.generate(_n, (i) => _vmQuat(i + _n));
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final r = _vmSlerp(a[i], b[i], 0.5);
      _sink += r.w;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// 8. Quaternion rotate — rotate 1000 vec3 by quat
// =============================================================================

class QuatRotateM extends BenchmarkBase {
  QuatRotateM() : super('QuatRotate.m');

  late List<m.quat> quats;
  late List<m.vec3> vecs;
  double _sink = 0;

  @override
  void setup() {
    quats = List.generate(_n, (i) => _mQuat(i));
    vecs = List.generate(_n, (i) => _mVec3(i));
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      final r = quats[i].rotate(vecs[i]);
      _sink += r.x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

class QuatRotateVM extends BenchmarkBase {
  QuatRotateVM() : super('QuatRotate.vector_math');

  late List<vm.Quaternion> quats;
  late List<vm.Vector3> vecs;
  late vm.Vector3 _scratch;
  double _sink = 0;

  @override
  void setup() {
    quats = List.generate(_n, (i) => _vmQuat(i));
    vecs = List.generate(_n, (i) => _vmVec3(i));
    _scratch = vm.Vector3.zero();
  }

  @override
  void run() {
    for (var i = 0; i < _n; i++) {
      _scratch.setFrom(vecs[i]);
      quats[i].rotate(_scratch);
      _sink += _scratch.x;
    }
    if (_sink == -999) throw StateError('sink');
  }
}

// =============================================================================
// main
// =============================================================================

final _benchmarks = <String, BenchmarkBase Function()>{
  'vec3arith.m': Vec3ArithM.new,
  'vec3arith.vm': Vec3ArithVM.new,
  'vec3funcs.m': Vec3FuncsM.new,
  'vec3funcs.vm': Vec3FuncsVM.new,
  'vec3batch.m': Vec3BatchM.new,
  'vec3batch.vm': Vec3BatchVM.new,
  'mat4chain.m': Mat4ChainM.new,
  'mat4chain.vm': Mat4ChainVM.new,
  'mat4transform.m': Mat4TransformM.new,
  'mat4transform.vm': Mat4TransformVM.new,
  'camera.m': CameraSetupM.new,
  'camera.vm': CameraSetupVM.new,
  'quatslerp.m': QuatSlerpM.new,
  'quatslerp.vm': QuatSlerpVM.new,
  'quatrotate.m': QuatRotateM.new,
  'quatrotate.vm': QuatRotateVM.new,
};

void main(List<String> args) {
  if (args.isNotEmpty) {
    for (final name in args) {
      final factory = _benchmarks[name];
      if (factory == null) {
        print('Unknown benchmark: $name');
        print('Available: ${_benchmarks.keys.join(', ')}');
        return;
      }
      factory().report();
    }
    return;
  }

  print('m vs vector_math benchmark');
  print('  m:          immutable (operators return new instances)');
  print('  vector_math: mutable  (in-place methods, scratch objects)');
  print('');

  print('--- Vec3 arithmetic: add + scale + negate, $_n vectors ---');
  Vec3ArithM().report();
  Vec3ArithVM().report();
  print('');

  print(
    '--- Vec3 functions: normalize, dot, cross, length, reflect, $_n vectors ---',
  );
  Vec3FuncsM().report();
  Vec3FuncsVM().report();
  print('');

  print('--- Vec3 batch: position += velocity * dt, $_n entities ---');
  Vec3BatchM().report();
  Vec3BatchVM().report();
  print('');

  print('--- Mat4 chain: inverseBind * jointWorld * skinRoot, 100 bones ---');
  Mat4ChainM().report();
  Mat4ChainVM().report();
  print('');

  print('--- Mat4 transform: MVP * position, $_n vertices ---');
  Mat4TransformM().report();
  Mat4TransformVM().report();
  print('');

  print('--- Camera setup: lookAt + perspective, 100 iterations ---');
  CameraSetupM().report();
  CameraSetupVM().report();
  print('');

  print('--- Quaternion slerp: interpolate $_n pairs ---');
  QuatSlerpM().report();
  QuatSlerpVM().report();
  print('');

  print('--- Quaternion rotate: rotate $_n vec3 by quat ---');
  QuatRotateM().report();
  QuatRotateVM().report();
}
