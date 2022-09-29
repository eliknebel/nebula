import component.{Element, Props, Text}

pub fn el(tag: String, props: Props) {
  Element(tag, props)
}

pub fn text(text: String) {
  Text(text)
}
