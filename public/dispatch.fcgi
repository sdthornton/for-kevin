# Uncomment on production

# #!/home/cutthechi/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

# ENV['RAILS_ENV'] ||= 'production'
# ENV['HOME'] ||= '/home/cutthechi'
# ENV['GEM_HOME'] = File.expand_path('~/.rvm/gems/ruby-2.0.0-p247')
# ENV['GEM_PATH'] = File.expand_path('~/.rvm/gems/ruby-2.0.0-p247') + ":" + File.expand_path('~/.rvm/gems/ruby-2.0.0-p247@global')

# require 'fcgi'
# require File.join(File.dirname(__FILE__), '../config/environment')

# class Rack::PathInfoRewriter
#   def initialize(app)
#     @app = app
#   end

#   def call(env)
#     env.delete('SCRIPT_NAME')
#     parts = env['REQUEST_URI'].split('?')
#     env['PATH_INFO'] = parts[0]
#     env['QUERY_STRING'] = parts[1].to_s
#     @app.call(env)
#   end
# end

# Rack::Handler::FastCGI.run  Rack::PathInfoRewriter.new(AzcutthechiCom::Application)
