import gleam/list
import gleam/string
import component.{Component, Element, Props, Text}

pub fn render(el: Element) -> String {
  case el {
    Component(c) -> render_component(c)
    Element(tag, props) -> render_tag(tag, props)
    Text(s) -> s
  }
}

fn render_component(fc: fn() -> List(Element)) {
  fc()
  |> list.map(fn(child) { render(child) })
  |> string.concat
}

fn render_tag(tag: String, props: Props) {
  let Props(key: _key, children: children) = props
  let inner_html =
    children
    |> list.map(fn(child) { render(child) })
    |> string.concat

  ["<", tag, ">", inner_html, "</", tag, ">"]
  |> string.concat()
}
