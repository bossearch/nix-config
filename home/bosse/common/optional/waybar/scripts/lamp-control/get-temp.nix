{
  home.file.".config/waybar/scripts/lamp-control/get-temp.py" = {
    text = ''
      import socket
      import json

      # Configuration
      lamp_ip = "192.168.18.14"
      port = 38899

      def send_request(data):
          with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
              sock.settimeout(1)
              sock.sendto(data.encode(), (lamp_ip, port))
              try:
                  response, _ = sock.recvfrom(1024)
                  return response.decode()
              except socket.timeout:
                  return "No response"

      def get_temperature():
          request = json.dumps({"method": "getPilot"})
          response = send_request(request)

          try:
              result = json.loads(response).get("result")
              return result.get("temp", 2700)  # Default to 2700 if not available

          except json.JSONDecodeError:
              return "Failed to decode JSON response"

      if __name__ == "__main__":
          temp = get_temperature()
          print(temp)

    '';
  };
}
