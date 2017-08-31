class GrpcServer
  class << self

    def start
      @server = GRPC::RpcServer.new(pool_size: 30, max_waiting_requests: 30)

      @server.add_http2_port('0.0.0.0:50052', :this_port_is_insecure)

      @server.handle(ResourceHandler)

      Log.log.info "Starting grpc server on #{host_port}"
      @server.run_till_terminated
    end
  end
end
