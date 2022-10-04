import gleam/erlang/process
import gleam/http/cowboy
import gleam/http/response.{Response}
import gleam/http/request.{Request}
import gleam/bit_builder.{BitBuilder}
import gleam/option.{None, Some}
import component.{Component, ComponentContext, Props}
import render.{render}
import components/clock.{ClockProps, clock}
import components/html.{BodyProps, H1Props, HtmlProps, body, el, h1, html, text}

// Define a HTTP service
//
pub fn my_service(context: ComponentContext) {
  fn(_request: Request(t)) -> Response(BitBuilder) {
    let app =
      Component(fn(_) {
        [
          html(HtmlProps(children: [
            body(BodyProps(children: [
              el(
                "div",
                Props(
                  key: None,
                  children: [
                    h1(H1Props(children: [text("Hello, World!")])),
                    clock(ClockProps(label: Some("The current time is: "))),
                  ],
                ),
              ),
              el("div", Props(key: None, children: [text("test")])),
            ])),
          ])),
        ]
      })

    let body =
      render(app, context)
      |> bit_builder.from_string

    response.new(200)
    |> response.prepend_header("made-with", "Gleam")
    |> response.set_body(body)
  }
}

// Start it on port 3000!
//
pub fn main() {
  // TODO: these are just dummy functions to simulate state management.
  // We will have to implement some sort of actor linked to the websocket
  // session to store and update this data
  let push_hook = fn(h) { h }
  let state_updater = fn(_index) { fn(s) { s } }

  let context =
    ComponentContext(
      hooks: [],
      h_index: 0,
      push_hook: push_hook,
      state_updater: state_updater,
    )
  let _ = cowboy.start(my_service(context), on_port: 3000)
  process.sleep_forever()
}
