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

    if params["title"]["name"].empty?
      params["figure"]["title_ids"].each do |t|
        f.titles << Title.find_by_id(t)
      end
    else
      f.titles = Title.find_or_create_by(name: params["title"]["name"])
    end


    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |l|
        f.landmarks << Landmark.find_by_id(l)
      end
    else
      f.landmarks << Landmark.find_or_create_by(params["landmark"]["name"])
    end

    f.save
  end

end
