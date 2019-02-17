require 'socket';
require 'context';

class Server
  def initialize(host, port)
    @server = TCPServer.new(host, port);
    puts "Server listening on #{host}:#{port}";
  
    loop{
      context = Context.new(@server.accept);
      
      Thread.new{
        begin
        proc.(context);
        context.close;
        rescue Exception => e
          puts "Exception: #{e}";
          begin
          context.send("Internal server error", status="500 Internal Server Error");
          context.close;
          rescue Exception => e
            puts "Could not close context: #{e}";
          end
        end
      }
    }
  end
end
