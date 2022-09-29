import gleam/erlang/process
import gleam/http/cowboy
import gleam/http/response.{Response}
import gleam/http/request.{Request}
import gleam/bit_builder.{BitBuilder}
import gleam/option.{None, Some}
import component.{Component, Props}
import render.{render}
import components/header.{HeaderProps, header}
import components/clock.{ClockProps, clock}
import html.{el}

// Define a HTTP service
//
pub fn my_service(_request: Request(t)) -> Response(BitBuilder) {
  let app =
    Component(fn() {
      [
        el(
          "div",
          Props(
            key: None,
            children: [
              header(HeaderProps(title: "Hello, World!")),
              clock(ClockProps(label: Some("The current time is: "))),
            ],
          ),
        ),
      ]
    })

  let body =
    render(app)
    |> bit_builder.from_string

  response.new(200)
  |> response.prepend_header("made-with", "Gleam")
  |> response.set_body(body)
}

// Start it on port 3000!
//
pub fn main() {
  let _ = cowboy.start(my_service, on_port: 3000)
  process.sleep_forever()
}
