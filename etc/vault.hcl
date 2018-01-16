storage "couchdb" {
  endpoint = "http://127.0.0.1:5984/vault"
  username = "admin"
  password = "admin"
}

listener "tcp" {
 address = "127.0.0.1:8200"
 tls_disable = 1
}

ui = true
