class Context
  attr_reader :headers, :request, :ip, :path, :body;

  def send(body, status=200)
    send_header(status);
    send_body(body);
  end

  def close
    @socket.close;
  end

  private

  def send_header(status="200 OK")
    @socket.print("HTTP/1.1 #{status}\r\n\r\n");
  end

  def send_body(body="")
    @socket.print("#{body}\r\n");
  end

  def read_body(socket)
    recv_bytes = @headers['content-length'];
    return if recv_bytes.nil?;
    recv_bytes = recv_bytes.to_i;
    raise "Message size too large (#{recv_bytes})." if recv_bytes > 1e6; # Max 1MB message size.
    @body = socket.read(recv_bytes);
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
    @body = read_body(socket);

    @path = @request.split(' ')[1];

    # Determine IP behind proxy or not.
    # This is a serious security vulnerability in case you are not behind a proxy.
    @ip = headers['x-forwarded-for'] || socket.peeraddr.last;
  end
end
