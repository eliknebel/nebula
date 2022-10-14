import gleam/option.{None, Some}
import component.{Component}
import components/clock.{ClockProps, clock}
import components/html.{
  BodyProps, ElProps, H1Props, HtmlProps, body, el, h1, html, text,
}

pub type HelloViewProps {
  HelloViewProps
}

pub fn hello_view(_props: HelloViewProps) {
  Component(fn(_) {
    [
      html(
        HtmlProps,
        [
          body(
            BodyProps,
            [
              el(
                "div",
                ElProps(key: None),
                [
                  h1(H1Props, [text("Hello, World!")]),
                  clock(ClockProps(label: Some("The current time is: "))),
                ],
              ),
              el("div", ElProps(key: None), [text("A test component")]),
            ],
          ),
        ],
      ),
    ]
  })
}
