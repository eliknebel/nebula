import conn.{Conn, ResponseHeader}

pub fn made_with(label) {
  fn(conn: Conn) {
    Conn(
      ..conn,
      response_headers: [
        ResponseHeader("made-with", label),
        ..conn.response_headers
      ],
    )
  }
}
