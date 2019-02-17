#!/usr/bin/env ruby
$DIR = File.dirname(__FILE__);

$LOAD_PATH << "#{$DIR}/lib";

require 'server';
require 'json';
require 'base64';

$host = 'localhost';
$port = 9000;

server = Server.new($host, $port){ |context|
  puts "Request from: #{context.ip}";
  json = JSON.parse(context.body);

  puts "App: #{json['app_id']}";
  puts "Dev: #{json['dev_id']}";
  puts "Payload: #{Base64.decode64(json['payload_raw'])}";
  
  context.send("Hello world");
};
