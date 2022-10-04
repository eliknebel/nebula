import gleam/option.{None}
import component.{Component, Element, Props, Text}

pub fn el(tag: String, props: Props) {
  Element(tag, props)
}

pub fn text(text: String) {
  Text(text)
}

pub type HtmlProps {
  HtmlProps(children: List(Element))
}

pub fn html(props: HtmlProps) {
  Component(fn(_) {
    let HtmlProps(children) = props

    [Element("html", Props(key: None, children: children))]
  })
}

pub type BodyProps {
  BodyProps(children: List(Element))
}

pub fn body(props: BodyProps) {
  Component(fn(_) {
    let BodyProps(children) = props

    [Element("body", Props(key: None, children: children))]
  })
}

pub type H1Props {
  H1Props(children: List(Element))
}

pub fn h1(props: H1Props) {
  Component(fn(_) {
    let H1Props(children) = props

    [Element("h1", Props(key: None, children: children))]
  })
}
