require 'open-uri'

class Api::V1::Parser::Parser
  attr_accessor :proxy

  def initialize
    set_proxy
    setup
  end

  def get_content(uri)
    open(uri, proxy).read
  end

  private

  def set_proxy
    @proxy = {
      proxy_use: ENV['PROXY_USE'],
      proxy_host: ENV['PROXY_HOST'],
      proxy_port: ENV['PROXY_PORT'],
      proxy_user: ENV['PROXY_USER'],
      proxy_password: ENV['PROXY_PASSWORD']
    }
  end

  def setup
    @proxy = @proxy[:proxy_use] ? {
      proxy_http_basic_authentication: [
        "#{@proxy[:proxy_host]}:#{@proxy[:proxy_port]}",
        @proxy[:proxy_user],
        @proxy[:proxy_password]
      ]
    } : {}
  end
end
