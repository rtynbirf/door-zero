#!/usr/bin/env python3
# Door Zero: GET -> 204 No Content; POST/PUT/PATCH/DELETE -> 403 Void.
# Ноль логов, ноль кук, ноль телеметрии. Только stdlib.
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

class Void(BaseHTTPRequestHandler):
    def log_message(self, *a):  # ноль телеметрии
        pass
    def do_GET(self):
        self.send_response(204)
        self.end_headers()
    def _void(self):
        self.send_response(403)
        self.send_header("X-Void", "1")
        self.end_headers()
    do_POST = do_PUT = do_PATCH = do_DELETE = _void

if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8907
    HTTPServer(("127.0.0.1", port), Void).serve_forever()
