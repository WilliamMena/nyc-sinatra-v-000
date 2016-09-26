class FiguresController < ApplicationController

  get '/figures' do
    "Hello World - Figures"
  end

  get '/figures/new' do
    @titles =  Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do 
    f = Figure.find_or_create_by(name: params["figure"]["name"])
    params["figure"]["title_ids"].each do |t|
      f.titles << Title.find_by_id(t)
    end
    binding.pry
    params["figure"]["landmark_ids"].each do |l|
      f.landmarks << Landmark.find_by_id(l)
    end
    f.save
  end

end
