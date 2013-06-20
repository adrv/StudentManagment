StudentManagment::Application.routes.draw do
  
  resource :students, only: [:create, :index] do
    post 'search'
  end

  root to: "students#index"

end
