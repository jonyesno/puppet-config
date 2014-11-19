vcl 4.0;

backend default {
  .host = "127.0.0.1";
  .port = "8000";
}

sub vcl_backend_response {
  if (beresp.http.Location) {
    set beresp.http.Location = regsub(beresp.http.Location, "^(\w+://[^/]+):\d+", "\1");
  }
}
