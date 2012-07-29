EYC::Application.routes.draw do

  resources :survey_responses

  resources :users
  resources :sessions
  resources :surveys

  get "take_survey_new" => "surveys#take_survey_new", :as => "take_survey_new"
  get "TakeASurvey/:id" => "surveys#take_survey_new", :as => "TakeASurvey"
  put "take_survey_create" => "surveys#take_survey_create", :as => "take_survey_create"
  get "survey_answer" => "surveys#survey_answer", :as => "survey_answer"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  root :to => "users#home"
  
end
