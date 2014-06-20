require "log4r"

module VagrantPlugins
  module Openstack
    module Action
      class StopServer
        def initialize(app, _env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_openstack::action::stop_server")
        end

        def call(env)
          if env[:machine].id
            env[:ui].info(I18n.t("vagrant_openstack.stopping_server"))
            client = env[:openstack_client]
            client.stop_server(env, env[:machine].id)
          end
          @app.call(env)
        end
      end
    end
  end
end
