import conn.{Conn, ResponseHeader}

pub fn made_with(conn: Conn) {
  Conn(
    ..conn,
    response_headers: [
      ResponseHeader("made-with", "Gleam"),
      ..conn.response_headers
    ],
  )
}
