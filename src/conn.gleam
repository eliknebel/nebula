import gleam/http/response
import gleam/http/request.{Request}
import gleam/bit_builder
import component.{ComponentContext}

pub type Conn {
  Conn(req: Request(BitString), context: ComponentContext)
}

pub fn send_resp(_conn, status, body) {
  response.new(status)
  |> response.prepend_header("made-with", "Gleam")
  |> response.set_body(bit_builder.from_string(body))
}

pub fn error(_conn, status, body) {
  response.new(status)
  |> response.prepend_header("made-with", "Gleam")
  |> response.set_body(bit_builder.from_string(body))
}
