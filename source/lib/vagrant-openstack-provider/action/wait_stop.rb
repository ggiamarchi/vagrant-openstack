require "log4r"
require "timeout"

module VagrantPlugins
  module Openstack
    module Action
      class WaitForServerToStop
        def initialize(app, _env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_openstack::action::stop_server")
        end

        def call(env)
          if env[:machine].id
            env[:ui].info(I18n.t("vagrant_openstack.waiting_stop"))
            client = env[:openstack_client].nova
            timeout(200) do
              while client.get_server_details(env, env[:machine].id)['status'] != 'SHUTOFF'
                sleep 3
                @logger.debug("Waiting for server to stop")
              end
            end
          end
          @app.call(env)
        end
      end
    end
  end
end
