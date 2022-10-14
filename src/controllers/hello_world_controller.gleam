import components/app.{AppProps, app}
import conn.{Conn, send_resp}
import render.{render}

pub fn hello_world(conn: Conn) {
  let Conn(context: context, ..) = conn

  let app = app(AppProps)

  let body = render(app, context)

  conn
  |> send_resp(200, body)
}
