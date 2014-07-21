require 'faye'

Faye::WebSocket.load_adapter 'passenger'

use Faye::RackAdapter, :mount => '/faye',
                       :timeout => 25,
                       :server => 'passenger',
                       :engine => {type: Faye::Redis,
                                   host: 'localhost'}

require ::File.expand_path('../config/environment',  __FILE__)

run Rails.application
