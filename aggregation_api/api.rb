#!/usr/bin/env ruby
$DIR = File.dirname(__FILE__);

$LOAD_PATH << "#{$DIR}/lib";

require 'server';

$host = 'localhost';
$port = 9000;

server = Server.new($host, $port){ |context|
  puts "Request from: #{context.ip} body: #{context.body}";
  context.send("Hello world");
};
