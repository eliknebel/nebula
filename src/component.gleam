import gleam/option.{Option}

pub type Props {
  Props(key: Option(String), children: List(Element))
}

pub type Element {
  Element(tag: String, props: Props)
  Text(text: String)
}
