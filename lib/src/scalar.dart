/// 32-bit float scalar.
extension type const f32._(double _) {
  static const zero = f32(0);

  const f32(double v) : _ = v;

  f32 operator +(f32 other) => f32._(_ + other._);
  f32 operator -(f32 other) => f32._(_ - other._);
  f32 operator -() => f32._(-_);
  f32 operator *(f32 other) => f32._(_ * other._);
  f32 operator /(f32 other) => f32._(_ / other._);
  f32 operator %(f32 other) => f32._(_ % other._);
  bool operator >(f32 other) => _ > other._;
  bool operator >=(f32 other) => _ >= other._;
  bool operator <(f32 other) => _ < other._;
  bool operator <=(f32 other) => _ <= other._;

  double get value => _;
}

/// Unsigned 32-bit integer scalar.
extension type const u32._(int _) {
  static const zero = u32(0);

  const u32(int v) : _ = v;

  u32 operator +(u32 other) => u32._(_ + other._);
  u32 operator -(u32 other) => u32._(_ - other._);
  u32 operator -() => u32._(-_);
  u32 operator *(u32 other) => u32._(_ * other._);
  u32 operator /(u32 other) => u32._(_ ~/ other._);
  u32 operator %(u32 other) => u32._(_ % other._);
  u32 operator &(u32 other) => u32._(_ & other._);
  u32 operator |(u32 other) => u32._(_ | other._);
  u32 operator ^(u32 other) => u32._(_ ^ other._);
  u32 operator <<(u32 other) => u32._(_ << other._);
  u32 operator >>(u32 other) => u32._(_ >> other._);
  u32 operator ~() => u32._(~_);
  bool operator >(u32 other) => _ > other._;
  bool operator >=(u32 other) => _ >= other._;
  bool operator <(u32 other) => _ < other._;
  bool operator <=(u32 other) => _ <= other._;

  int get value => _;
}

/// Signed 32-bit integer scalar.
extension type const i32._(int _) {
  static const zero = i32(0);

  const i32(int v) : _ = v;

  i32 operator +(i32 other) => i32._(_ + other._);
  i32 operator -(i32 other) => i32._(_ - other._);
  i32 operator -() => i32._(-_);
  i32 operator *(i32 other) => i32._(_ * other._);
  i32 operator /(i32 other) => i32._(_ ~/ other._);
  i32 operator %(i32 other) => i32._(_ % other._);
  i32 operator &(i32 other) => i32._(_ & other._);
  i32 operator |(i32 other) => i32._(_ | other._);
  i32 operator ^(i32 other) => i32._(_ ^ other._);
  i32 operator <<(i32 other) => i32._(_ << other._);
  i32 operator >>(i32 other) => i32._(_ >> other._);
  i32 operator ~() => i32._(~_);
  bool operator >(i32 other) => _ > other._;
  bool operator >=(i32 other) => _ >= other._;
  bool operator <(i32 other) => _ < other._;
  bool operator <=(i32 other) => _ <= other._;

  int get value => _;
}

extension GpuInt on int {
  u32 get u => u32._(this);
  i32 get i => i32._(this);
}

extension GpuDouble on double {
  f32 get f => f32._(this);
}

extension U32Cast on u32 {
  f32 get f => f32._(_.toDouble());
  i32 get i => i32._(_);
}

extension I32Cast on i32 {
  f32 get f => f32._(_.toDouble());
  u32 get u => u32._(_);
}

extension F32Cast on f32 {
  u32 get u => u32._(_.toInt());
  i32 get i => i32._(_.toInt());
}
