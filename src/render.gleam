import gleam/list
import gleam/string
import component.{Component, ComponentContext, Element, Text}

pub fn render(el: Element, ctx: ComponentContext) -> String {
  case el {
    Component(c) -> render_component(c, ctx)
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
