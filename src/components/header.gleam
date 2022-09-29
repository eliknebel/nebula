import gleam/option.{None}
import component.{Component, Element, Props, Text}

pub type HeaderProps {
  HeaderProps(title: String)
}

pub fn header(props: HeaderProps) {
  Component(fn() {
    let HeaderProps(title) = props

    [Element("h2", Props(key: None, children: [Text(title)]))]
  })
}
