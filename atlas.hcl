env "local" {
  src = ["file://src/types", "file://src/tables"]
  dev = "docker://postgres/17/dev"

  migration {
    dir = "file://migrations"
  }
}
