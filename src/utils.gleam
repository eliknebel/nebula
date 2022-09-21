pub fn value_or(r: Result(t, Nil), default: t) -> t {
  case r {
    Ok(s) -> s
    _ -> default
  }
}
