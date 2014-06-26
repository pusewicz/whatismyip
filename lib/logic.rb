VERSION = "1.0.0"

set :public_folder, File.expand_path('../public', __FILE__)
set :views,  File.expand_path('../public', __FILE__)
set :env,    :production

before do
  response.headers['X-Application'] = server_info.first
  response.headers['X-Version']     = server_info.last

  response.headers['Expires']       = "-1"
  response.headers['Server']        = server_name

  response.headers['Cache-Control'] = 'private, max-age=0'
end

get "/redir/*" do |path|
  content_type 'text/plain', :charset => 'utf-8'
  remote_ip = extract_remote_ip
  url = params[:splat].join
  log(remote_ip, path, url)
  redirect url
end

get "*" do |path|
  content_type 'text/plain', :charset => 'utf-8'
  remote_ip = extract_remote_ip
  log(remote_ip, path)
  remote_ip
end

private
def extract_remote_ip
  request.ip || request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
end

def server_info
  [self.class.name, VERSION]
end

def server_name
  server_info.join('/')
end

def logger
  @logger ||= Logger.new(STDOUT)
end

def log(ip, path, redir = nil)
  logger.info("Requested `#{path.inspect}' from `#{ip}'")
  logger.info("Redirecting `#{ip}' to `#{redir}'") if redir
end
