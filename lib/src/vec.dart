import 'dart:math' as math;

part 'vec2.dart';
part 'vec3.dart';
part 'vec4.dart';
part 'veci.dart';
part 'vecu.dart';
part 'vech.dart';
part 'vecb.dart';

/// Base marker for all vector types.
sealed class vec {
  const vec();
}

/// Float vector base
sealed class vecf extends vec {
  const vecf();

  double get magnitude;
  vecf get normalized;
  double dotWith(covariant vecf other);
  double distanceTo(covariant vecf other);
  vecf reflectOn(covariant vecf normal);
  vecf mixWith(covariant vecf other, double t);
  vecf mixWithVec(covariant vecf other, covariant vecf t);
  vecf smoothstepWith(covariant vecf edge0, covariant vecf edge1);
}

/// Signed integer vector base.
sealed class veci extends vec {
  const veci();

  int dotWith(covariant veci other);
}

/// Unsigned integer vector base.
sealed class vecu extends vec {
  const vecu();

  int dotWith(covariant vecu other);
}

/// Boolean vector base
sealed class vecb extends vec {
  const vecb();

  /// True if any component is true.
  bool get any;

  /// True if all components are true.
  bool get all;

  /// Component-wise logical NOT.
  vecb get not;
}

@pragma('vm:prefer-inline')
@pragma('wasm:prefer-inline')
@pragma('dart2js:tryInline')
double _ss(double v, double e0, double e1) {
  var t = (v - e0) / (e1 - e0);
  t = t < 0.0 ? 0.0 : (t > 1.0 ? 1.0 : t);
  return t * t * (3.0 - 2.0 * t);
}
