require './dossier'

map('/api/v1') do
  run DossierEndpoint
end