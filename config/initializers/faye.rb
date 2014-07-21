# Ensure Faye is running for processes outside Rails.
#Faye.ensure_reactor_running!

config.middleware.use FayeRails::Middleware, mount: '/faye',
                                             :timeout => 25,
                                             server: 'passenger',
                                             engine: {type: Faye::Redis,
                                                      host: 'localhost'}
