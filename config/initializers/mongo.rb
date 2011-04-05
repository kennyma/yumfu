MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 27017, {
  :auto_reconnect => true, 
  :logger         => Rails.logger
})

MongoMapper.database = "yumfu-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end

Dir.glob("#{RAILS_ROOT}/app/models/**/*.rb") do |model_path|
  File.basename(model_path, ".rb").classify.constantize
end