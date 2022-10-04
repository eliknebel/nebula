import gleam/option.{Option}
import gleam/list.{at}

pub type Props {
  Props(key: Option(String), children: List(Element))
}

type StateValue =
  String

pub type Hook {
  State(state: StateValue, updater: fn(StateValue) -> StateValue)
}

pub type ComponentContext {
  ComponentContext(
    hooks: List(Hook),
    push_hook: fn(Hook) -> Hook,
    h_index: Int,
    state_updater: fn(Int) -> fn(StateValue) -> StateValue,
  )
}

pub type Element {
  Element(tag: String, props: Props)
  Component(c: fn(ComponentContext) -> List(Element))
  Text(text: String)
}

pub fn use_state(ctx: ComponentContext, initial: StateValue) -> Hook {
  let ComponentContext(
    hooks: hooks,
    h_index: h_index,
    push_hook: push_hook,
    state_updater: state_updater,
  ) = ctx

  case at(hooks, h_index) {
    Ok(h) -> h
    Error(Nil) -> push_hook(State(initial, state_updater(h_index)))
  }
}
