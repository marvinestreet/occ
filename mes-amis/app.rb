require 'sinatra'
require 'pg'
require 'ipaddr'

set :bind, '0.0.0.0'

# Rack::Protection::HostAuthorization rejects unknown Host headers. ALB health
# checks send Host=<task-IP>, while external clients send Host=<ALB DNS>, so
# both shapes have to be permitted. We mirror Sinatra's dev default for IP
# literals (0.0.0.0/0) and add the ALB DNS via PERMITTED_HOSTS.
set :host_authorization, {
  permitted_hosts: ENV.fetch('PERMITTED_HOSTS', '').split(',').reject(&:empty?) +
                   [IPAddr.new('0.0.0.0/0'), IPAddr.new('::/0')],
}

# AWS health check
get '/ping' do
  'pong'
end

# Returns the current time as reported by the database
get '/current_time' do
  conn = PG.connect(ENV.fetch('DATABASE_URL'))
  begin
    conn.exec('SELECT NOW() AS now') { |result| result[0]['now'] }
  ensure
    conn.close
  end
end
