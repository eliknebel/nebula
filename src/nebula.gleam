import router.{get, router, scope, start}
import controllers/hello_world_controller.{hello_world}

// Define a router and start it on port 3000!
pub fn main() {
  router([scope("/hello", [], [get("/world", hello_world)])])
  |> start(3000)
}
