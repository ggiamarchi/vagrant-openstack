require 'log4r'
require 'restclient'
require 'json'

require 'vagrant-openstack-provider/client/keystone'
require 'vagrant-openstack-provider/client/nova'
require 'vagrant-openstack-provider/client/neutron'

module VagrantPlugins
  module Openstack
    class Session
      include Singleton

      attr_accessor :token
      attr_accessor :project_id
      attr_accessor :endpoints

      def initialize
        @token = nil
        @project_id = nil
        @endpoints = {}
      end

      def reset
        initialize
      end
    end

    def self.session
      Session.instance
    end

    def self.keystone
      Openstack::KeystoneClient.instance
    end

    def self.nova
      Openstack::NovaClient.instance
    end

    def self.neutron
      Openstack::NeutronClient.instance
    end
  end
end
