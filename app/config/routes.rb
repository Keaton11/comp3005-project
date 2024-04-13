Rails.application.routes.draw do
  resources :fitness_class_exercise_routines
  resources :fitness_class_equipments
  resources :equipment
  resources :exercise_routines
  resources :fitness_goals
  resources :exercises
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :trainers do
    get 'schedule', on: :collection
  end

  resources :members do
    get 'schedule', on: :collection
    get 'dashboard', on: :collection
    get 'bills', on: :collection
  end

  resources :staffs do
    get 'schedule', on: :collection
    get 'bills', on: :collection
  end

  resources :rooms do
    get 'available_rooms', on: :collection
    get 'bookings', on: :collection
    post 'update_class_room', on: :collection
  end

  resources :bills do
    patch 'pay', on: :member
    patch 'staff_pay', on: :member
    patch 'staff_remove_payment', on: :member
    delete 'delete_personal_fitness_class', on: :collection
    delete 'delete_group_fitness_class', on: :collection
  end

  resources :fitness_classes do
    collection do
      delete '/', action: :handle_empty_delete
      get 'by_trainer/:trainer_id', action: :by_trainer
      get 'group_sessions/:member_id', action: :group_sessions
      get 'details/:fitness_class_id', action: :details, as: :details
      get 'all_group_sessions', action: :all_group_sessions
    end

    member do
      patch 'update_times', action: :update_times
    end
  end
  
  resources :fitness_class_members do
    collection do
      get 'for_member_non_grouped/:member_id', action: :for_member_non_grouped, as: :for_member_non_grouped
      delete 'destroy_by_member_and_class/:fitness_class_id/:member_id', action: 'destroy_by_member_and_class'
    end
  end

  resources :availabilities do
    collection do
      delete '/', action: :handle_empty_delete
      get 'all'
    end
  end

  resources :completed_exercise_routines do
    collection do
      get 'member_routines/:member_id', action: :member_routines
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root 'home#index'
end
