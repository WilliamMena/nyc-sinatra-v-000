class FiguresController < ApplicationController

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles =  Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do 
    f = Figure.find_or_create_by(name: params["figure"]["name"])

   if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |t|
        f.titles << Title.find_by_id(t)
      end
    else
      f.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |l|
        f.landmarks << Landmark.find_by_id(l)
      end
    else
      f.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    end

    f.save
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params["figure"]["name"]
    @figure.landmarks.clear
    @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end






end
