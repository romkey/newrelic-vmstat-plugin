#!/usr/bin/env ruby

# records vmstat output on New Relic

require 'newrelic_plugin'

module VmstatAgent
  class Agent < NewRelic::Plugin::Agent::Base
    agent_guid "com.romkey.newrelic.plugins.vmstat"
    agent_human_labels("Platform") { `hostname` }
    agent_version '0.1.0'

    def poll_cycle
      stats = memory_stats

      if stats
        stats.each do |key, measurement|
          if key.match /page/
            value = 'Pages'
          else
            value = 'Bytes'
            measurement = measurement.to_i * 1024
          end

          report_metric key, value, measurement
        end
      end
    end

    private
    def memory_stats
      info = {}
      vmstats = `vmstat -s`.split("\n").select { |s| s.match(/memory|swap|page/) }

      vmstats.each do |stat|
        results = stat.match /(\d+) (K )*(.+)/
        info[results[3]] = results[1]
      end

      return info
    end

    NewRelic::Plugin::Config.config_file = "config/vmstat_config.yml"
    NewRelic::Plugin::Setup.install_agent :vmstat, VmstatAgent
    NewRelic::Plugin::Run.setup_and_run
  end
end
