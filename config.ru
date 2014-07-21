require 'faye'
require 'faye/redis'


Faye::WebSocket.load_adapter 'thin'

use Faye::RackAdapter, :mount => '/faye',
                       :timeout => 25,
                       :server => 'thin',
                       :engine => {type: Faye::Redis,
                                   host: 'localhost'}

require ::File.expand_path('../config/environment',  __FILE__)

run Rails.application
