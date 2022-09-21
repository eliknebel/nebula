import gleam/option.{Option}
import gleam/list
import gleam/string

pub fn render(el: Element) {
  case el {
    Element(t: Tag(tag), props: Props(key: _, children: children)) ->
      render_tag(tag, children)
    Element(t: Component(c), props: Props(key: key, children: children)) ->
      render_component(c, key, children)
    Html(html: html) -> html
  }
}

fn render_tag(tag: String, children: Children) {
  let inner_html =
    children
    |> list.map(render)
    |> string.concat

  ["<", tag, ">", inner_html, "</", tag, ">"]
  |> string.concat()
}

fn render_component(c: Component, key: Option(Key), children: Children) {
  Props(key: key, children: children)
  |> c()
  |> render()
}

pub type Props {
  Props(key: Option(Key), children: Children)
}

pub type Element {
  Html(html: String)
  Element(t: ElType, props: Props)
}

pub type Key =
  String

pub type Children =
  List(Element)

pub type Component =
  fn(Props) -> Element

pub type ElType {
  Tag(s: String)
  Component(c: Component)
}

pub fn create_element(t: ElType, props: Props) {
  Element(t: t, props: props)
}

pub fn el(tag: String, props: Props) {
  create_element(Tag(tag), props)
}
