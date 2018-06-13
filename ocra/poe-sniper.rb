require_relative '../lib/poe/sniper.rb'

raise "No SSL support" unless EM.ssl?

Poe::Sniper.run('config.ini')
