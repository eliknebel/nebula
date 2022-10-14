import views/hello_view.{HelloViewProps, hello_view}
import conn.{Conn, send_resp}
import render.{render}

pub fn hello_world(conn: Conn) {
  let Conn(context: context, ..) = conn

  let view = hello_view(HelloViewProps)
  let body = render(view, context)

  conn
  |> send_resp(200, body)
}
