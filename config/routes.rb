Rails.application.routes.draw do
resources :spendings
# /spendings_export
get '/spending_export' => 'spendings#export'
  resources :agreements do
    member do
      # /agreements/:id/export
      get 'export'
    end
  end
end
