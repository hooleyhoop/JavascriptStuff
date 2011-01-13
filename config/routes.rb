JavascriptStuff::Application.routes.draw do

  get "upload_test/home"

  get "upload_test/contact"

  get "widgets/show"

  resources :elephants

  match 'pages' => 'pages#control_center'

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=horizontalList1     -- gives us params[:cellName]       = horizontalList1
    # http://0.0.0.0:3000/widgets/cellRenderer/horizontalList1              -- gives us params[:optionalArg1]   = horizontalList1
  match "/widgets/:name(/:optionalArg1)" => "widgets#show"

  root :to => "pages#index"
  #get "pages/control_center"

  get "pages/javascript_unit_tests"
  get "pages/widgets"
  get "pages/single_widget"
  get "pages/sample_fixed_page"
  get "pages/sample_elastic_page"
  get "pages/grid_view"
  get "pages/list_view"
  get "pages/horizontal_list_view"
  get 'pages/test_audioboo_stuff'

  # woo! a more complicated route. Lets try sending a variable
  match 'pages/sample_elastic_page/:id' => 'pages#sample_elastic_page'

  #ajax test - not sure if this is right?
  get "pages/_ajaxHTML"
  get "pages/_singlePartialViaAjaxFromParam"

  get "upload_test/simple_form"
  post "upload_test/upload"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
