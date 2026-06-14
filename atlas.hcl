env "local" {
  src = [
    "file:///tables",
    "file:///functions/games",
    "file:///functions/points",
    "file:///functions/sysparams",
    "file:///functions/timers",
    "file:///functions/users",
    "file:///functions/wheel"
  ]
  url = getenv("ATLAS_DB_URL")
  dev = getenv("ATLAS_DEV_URL")
  migration {
    dir = "file:///migrations"
  }
}
