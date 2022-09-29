import gleam/option.{Option}

pub type Props(rprops) {
  Props(key: Option(String), rprops: rprops, children: List(Element(rprops)))
}

pub type Element(rprops) {
  Element(tag: String, props: Props(rprops))
  Component(c: fn(rprops) -> List(Element(rprops)), props: rprops)
  Text(text: String)
}
