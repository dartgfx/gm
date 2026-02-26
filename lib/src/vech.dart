part of 'vec.dart';

/// 2-component half-precision float vector.
extension type const vec2h(vec2 _) implements vec2 {
  static const zero = vec2h(vec2.zero);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2h operator +(vec2h other) => vec2h(_ + other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2h operator -(vec2h other) => vec2h(_ - other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2h operator -() => vec2h(-_);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2h operator *(vec2h other) => vec2h(_ * other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec2h operator /(vec2h other) => vec2h(_ / other._);
}

/// 3-component half-precision float vector.
extension type const vec3h(vec3 _) implements vec3 {
  static const zero = vec3h(vec3.zero);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3h operator +(vec3h other) => vec3h(_ + other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3h operator -(vec3h other) => vec3h(_ - other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3h operator -() => vec3h(-_);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3h operator *(vec3h other) => vec3h(_ * other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec3h operator /(vec3h other) => vec3h(_ / other._);
}

/// 4-component half-precision float vector.
extension type const vec4h(vec4 _) implements vec4 {
  static const zero = vec4h(vec4.zero);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4h operator +(vec4h other) => vec4h(_ + other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4h operator -(vec4h other) => vec4h(_ - other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4h operator -() => vec4h(-_);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4h operator *(vec4h other) => vec4h(_ * other._);

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  vec4h operator /(vec4h other) => vec4h(_ / other._);
}
