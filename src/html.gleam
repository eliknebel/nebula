import gleam/list
import gleam/string
import component.{Component, Element, Props, Text}

pub fn render(el: Element(rprops)) -> String {
  case el {
    Component(c, props) -> render_component(c, props)
    Element(tag, props) -> render_tag(tag, props)
    Text(s) -> s
  }
}

fn render_component(fc: fn(rprops) -> List(Element(rprops)), rprops: rprops) {
  fc(rprops)
  |> list.map(fn(child) { render(child) })
  |> string.concat
}

fn render_tag(tag: String, props: Props(rprops)) {
  let Props(key: key, children: children, rprops: _) = props
  let inner_html =
    children
    // |> list.map(fn(child) { child.c(child.props) })
    |> list.map(fn(child) { render(child) })
    |> string.concat

  ["<", tag, ">", inner_html, "</", tag, ">"]
  |> string.concat()
}
