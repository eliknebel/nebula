import gleam/list
import gleam/string
import component.{Component, ComponentContext, Element, Props, Text}

pub fn render(el: Element, ctx: ComponentContext) -> String {
  case el {
    Component(c) -> render_component(c, ctx)
    Element(tag, props) -> render_tag(tag, props, ctx)
    Text(s) -> s
  }
}

fn render_component(
  fc: fn(ComponentContext) -> List(Element),
  ctx: ComponentContext,
) {
  fc(ComponentContext(..ctx, h_index: 0))
  |> list.map(fn(child) { render(child, ctx) })
  |> string.concat
}

fn render_tag(tag: String, props: Props, context: ComponentContext) {
  let Props(key: _key, children: children) = props
  let inner_html =
    children
    |> list.map(fn(child) { render(child, context) })
    |> string.concat

  ["<", tag, ">", inner_html, "</", tag, ">"]
  |> string.concat()
}
