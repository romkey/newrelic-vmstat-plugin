## vmstat plugin for the New Relic

This plugin records the output of the vmstat command to the New Relic Platform.

To use this agent:

1. Run `bundle install`

2. Copy `config/vmstat_config.yml.example` to `config/vmstat_config.yml`

3. Edit `config/vmstat_config.yml` and replace "YOUR_LICENSE_KEY_HERE" with your New Relic license key

4. Edit `config/vmstat_config.yml` and set `description` to something that will uniquely describe the server being monitored

5. Run `ruby vmstat_agent.rb` to start the agent

6. Check the "Plugins" tab on New Relic to see the results - it will be several minutes before New Relic begins showing data

Copyright 2016 by John Romkey
This software is released under the MIT license
