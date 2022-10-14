import gleam/list
import gleam/string
import gleam/http/response.{Response}
import gleam/http/request.{Request}
import gleam/bit_builder.{BitBuilder}
import gleam/http/cowboy
import gleam/erlang/process
import conn.{Conn, error}
import component.{ComponentContext}

pub type Controller =
  fn(Conn) -> Response(BitBuilder)

pub type Method {
  GET
  PUT
  POST
  PATCH
  DELETE
}

pub type Route {
  Route(method: Method, path: String, controller: Controller)
  Scope(path: String, middleware: List(Middleware), routes: List(Route))
}

pub type Middleware {
  Middleware(f: fn(Conn) -> Conn)
}

pub type Router {
  Router(routes: List(Route))
}

pub fn router(routes: List(Route)) {
  Router(routes: routes)
}

pub fn scope(path: String, middleware: List(Middleware), routes: List(Route)) {
  Scope(path, middleware, routes)
}

pub fn get(path: String, controller: Controller) {
  Route(GET, path, controller)
}

pub fn start(router: Router, port: Int) {
  let _ = cowboy.start(router_service(router), on_port: port)

  process.sleep_forever()
}

fn router_service(router: Router) {
  // TODO: these are just dummy functions to simulate state management.
  // We will have to implement some sort of actor linked to the websocket
  // session to store and update this data
  let push_hook = fn(h) { h }
  let state_updater = fn(_index) { fn(s) { s } }

  let context =
    ComponentContext(
      hooks: [],
      h_index: 0,
      push_hook: push_hook,
      state_updater: state_updater,
    )

  fn(request: Request(BitString)) -> Response(BitBuilder) {
    let Request(path: path, ..) = request
    let Router(routes: routes) = router
    process_request(Conn(request, context), path, routes)
  }
}

fn process_request(conn: Conn, path: String, routes: List(Route)) {
  let path = case string.starts_with(path, "/") {
    True -> string.drop_left(path, 1)
    False -> path
  }

  case string.split_once(path, "/") {
    Ok(#(curr, next)) -> handle_current_segment(conn, curr, next, routes)
    Error(Nil) -> handle_current_segment(conn, path, "", routes)
  }
}

fn handle_current_segment(conn, curr, next, routes) {
  case matching_route(curr, routes) {
    Ok(route) ->
      case route {
        Route(controller: controller, ..) -> controller(conn)
        Scope(middleware: middleware, routes: routes, ..) ->
          conn
          |> apply_middleware(middleware)
          |> process_request(next, routes)
      }
    Error(Nil) ->
      conn
      |> error(404, "route not found")
  }
}

fn matching_route(path: String, routes: List(Route)) {
  list.find(
    routes,
    fn(r) {
      case r {
        Route(path: p, ..) -> p == path || p == string.concat(["/", path])
        Scope(path: p, ..) -> p == path || p == string.concat(["/", path])
      }
    },
  )
}

fn apply_middleware(conn: Conn, middleware: List(Middleware)) {
  list.fold(middleware, conn, fn(acc, m) { m.f(acc) })
}
