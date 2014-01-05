require './dossier'

use Rack::Cors do 
  allow do 
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
  end
end

map('/api/v1') do
  run DossierEndpoint
end