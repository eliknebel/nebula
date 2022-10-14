import gleam/list
import gleam/http/response
import gleam/http/request.{Request}
import gleam/bit_builder
import component.{ComponentContext}

pub type ResponseHeader {
  ResponseHeader(key: String, value: String)
}

pub type Conn {
  Conn(
    req: Request(BitString),
    context: ComponentContext,
    response_headers: List(ResponseHeader),
  )
}

fn attach_conn_headers(response, conn) {
  case conn {
    Conn(response_headers: headers, ..) ->
      list.fold(
        headers,
        response,
        fn(r, h) {
          let ResponseHeader(key: key, value: value) = h
          response.prepend_header(r, key, value)
        },
      )
    _ -> response
  }
}

pub fn send_resp(conn, status, body) {
  response.new(status)
  |> attach_conn_headers(conn)
  |> response.set_body(bit_builder.from_string(body))
}

pub fn error(conn, status, body) {
  response.new(status)
  |> attach_conn_headers(conn)
  |> response.set_body(bit_builder.from_string(body))
}
