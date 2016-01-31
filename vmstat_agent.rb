#!/usr/bin/env ruby

# records vmstat output on New Relic

#require "rubygems"
#require "bundler/setup"
require "newrelic_plugin"

module VmstatAgent
  class Agent < NewRelic::Plugin::Agent::Base
    agent_guid "com.romkey.newrelic.memory"
    agent_human_labels("Platform") { `hostname` }
    agent_version '0.0.1'

    def poll_cycle
      stats = memory_stats

      if stats
        stats.each do |key,value|
          report_metric key, value
        end
      end
    end

    private
    def memory_stats
      info = {}
      vmstats = `vmstat -s`.split("\n").select { |s| s.match(/memory|swap|page/) }

      vmstats.each do |stat|
        results = stat.match /(\d+) (K )*(.+)/
        info[results[3]] = info[results[1]
      end

      return info
    end

    NewRelic::Plugin::Config.config_file = "config/memory_config.yml"
    NewRelic::Plugin::Setup.install_agent :vmstat, VmstatAgent
    NewRelic::Plugin::Run.setup_and_run
end
