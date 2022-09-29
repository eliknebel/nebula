import gleam/erlang/process
import gleam/http/cowboy
import gleam/http/response.{Response}
import gleam/http/request.{Request}
import gleam/bit_builder.{BitBuilder}
import gleam/option.{None}
import gleam/erlang
import gleam/int
import component.{Element, Props, Text}
import html.{render}

// Define a HTTP service
//
pub fn my_service(request: Request(t)) -> Response(BitBuilder) {
  let current_time =
    erlang.system_time(erlang.Second)
    |> int.to_string()

  let body =
    Element(
      "div",
      Props(
        key: None,
        children: [
          Element("h2", Props(key: None, children: [Text("Hello, World!")])),
          Element(
            "p",
            Props(
              key: None,
              children: [Text("The current time is: "), Text(current_time)],
            ),
          ),
        ],
      ),
    )
    |> render()
    |> bit_builder.from_string

  response.new(200)
  |> response.prepend_header("made-with", "Gleam")
  |> response.set_body(body)
}

// Start it on port 3000!
//
pub fn main() {
  cowboy.start(my_service, on_port: 3000)
  process.sleep_forever()
}
