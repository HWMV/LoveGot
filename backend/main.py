# App backend (server) 실행을 위한 스크립트
# 추후 기능들을 확장적으로 엔드포인트들을 추가 

# main.py
import http.server
import socketserver
import os

# Cloud Run에서 기본으로 PORT=8080 환경 변수를 전달합니다.
PORT = int(os.environ.get("PORT", 8080))

# 간단한 기본 핸들러 (http://YOUR_URL/ 접속 시 "Hello World" 등 반환)
class MyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(b"Hello from LoveGot backend!\n")

with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
    print(f"Serving on port {PORT}...")
    httpd.serve_forever()
