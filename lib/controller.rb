require_relative 'gossip'

class ApplicationController < Sinatra::Base

#affichage GET par défaut
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

#affichage GET nouveau gossip
  get '/gossips/new' do
    erb :new_gossip
  end

#MAJ base de donnée nouveau gossip
  post '/gossips/new' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    puts "\nenvoi des données du formulaire à la base CSV\n\n"
    redirect '/'
  end

#affichage GET d'un gossip
  get '/gossips/:id' do
    @id = params["id"].to_i
    @gossip = Gossip.find(@id)
    erb :show
  end

#affichage GET edit gossip
  get '/gossips/:id/edit' do
    erb :edit
  end

#MAJ base de donnée edit gossip
  post '/gossips/:id/edit' do
    puts "\n\n\n"
    @id = params[:id].to_i
    puts params['gossip_content']
    Gossip.update(@id, params["gossip_content"])
    puts "\nupdate des données du formulaire mise à jour du CSV\n\n"
    redirect '/'
  end

end