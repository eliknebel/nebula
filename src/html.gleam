import gleam/list
import gleam/string
import component.{Element, Props, Text}

pub fn render(el: Element) {
  case el {
    Element(tag, props) -> render_tag(tag, props)
    Text(s) -> s
  }
}

fn render_tag(tag: String, props: Props) {
  let Props(key: key, children: children) = props
  let inner_html =
    children
    // |> list.map(fn(child) { child.c(child.props) })
    |> list.map(fn(child) { render(child) })
    |> string.concat

  ["<", tag, ">", inner_html, "</", tag, ">"]
  |> string.concat()
}
