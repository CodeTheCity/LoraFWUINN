class Context
  attr_reader :headers, :request, :ip, :path;

  def send(body, status=200)
    header(status);
    body(body);
  end

  def close
    @socket.close;
  end

  private

  def header(status="200 OK")
    @socket.print("HTTP/1.1 #{status}\r\n\r\n");
  end

  def body(body="")
    @socket.print("#{body}\r\n");
  end

  def read_headers(socket)
    headers = {};

    while true;
      header = socket.gets;
      break if header.nil? or header.strip.empty?;
      key = header[/^[^:]*/].downcase;
      value = header.sub(/^[^:]*:/, "").strip;
      headers[key] = value;
    end

    return headers;
  end

  def initialize(socket)
    @socket = socket;
    @request = socket.gets.strip;
    @headers = read_headers(socket);

    @path = @request.split(' ')[1];

    # Determine IP behind proxy or not.
    # This is a serious security vulnerability in case you are not behind a proxy.
    @ip = headers['x-forwarded-for'] || socket.peeraddr.last;
  end
end
