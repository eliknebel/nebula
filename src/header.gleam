import gleam/option.{None}
import component.{Element, Props, Text}

pub type HeaderProps {
  HeaderProps(title: String)
}

pub fn header(props: HeaderProps) {
  let HeaderProps(title) = props

  [
    Element(
      "h2",
      Props(key: None, rprops: HeaderProps(""), children: [Text(title)]),
    ),
  ]
}
