import gleam/list
import gleam/string
import gleam/option.{None, Option}
import component.{Component, Element, raw}
import render.{render}

pub type ElProps {
  ElProps(key: Option(String))
}

pub type Children =
  List(Element)

pub fn el(tag: String, props: ElProps, children: Children) {
  Component(fn(ctx) {
    let ElProps(key: _key) = props
    let inner_html =
      children
      |> list.map(fn(child) { render(child, ctx) })
      |> string.concat

    [
      ["<", tag, ">", inner_html, "</", tag, ">"]
      |> string.concat()
      |> raw(),
    ]
  })
}

pub fn text(text: String) -> Element {
  // TODO: should html escape text coming into this function
  raw(text)
}

pub type HtmlProps {
  HtmlProps
}

pub fn html(props: HtmlProps, children: Children) {
  Component(fn(_) {
    let HtmlProps = props

    [el("html", ElProps(key: None), children)]
  })
}

pub type BodyProps {
  BodyProps
}

pub fn body(props: BodyProps, children: Children) {
  Component(fn(_) {
    let BodyProps = props

    [el("body", ElProps(key: None), children)]
  })
}

pub type H1Props {
  H1Props
}

pub fn h1(props: H1Props, children: Children) {
  Component(fn(_) {
    let H1Props = props

    [el("h1", ElProps(key: None), children)]
  })
}
