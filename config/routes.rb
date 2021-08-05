Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :samples
      resources :bmap_flowcells
      resources :studies
      resources :samples_extraction_activities
      resources :stock_resources
      resources :qc_results
      resources :flgen_plates
      resources :lighthouse_samples
      resources :flowcells
      resources :pac_bio_runs
      resources :oseq_flowcells
    end
  end
end
