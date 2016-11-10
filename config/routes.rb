Rails.application.routes.draw do
  get 'subscription/get'
  get 'subscription/addchannel'
  get 'subscription/addshow'
  get 'subscription/removechannel'
  get 'subscription/removeshow'
  get 'tvguide/get'

  get 'general/error'

  get 'auth/login'
  root 'auth#login'
end
