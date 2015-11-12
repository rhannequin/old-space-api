class Parser
  attr_accessor :proxy

  def initialize(config)
    setup(config)
  end

  private

  def setup(config)
    @proxy = config[:proxy][:proxy_use] ? {
      proxy_http_basic_authentication: [
        "#{config[:proxy][:proxy_host]}:#{config[:proxy][:proxy_port]}",
        config[:proxy][:proxy_user],
        config[:proxy][:proxy_password]
      ]
    } : {}
  end
end
