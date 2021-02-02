Rails.application.routes.draw do
  devise_for :users,
    # パスワード入力せずにプロフィール編集するルーティング
    controllers: { registrations: 'registrations' }
  # 1. pages controllerのhomeアクションのルーテイングを追加
  # get 'pages/home'
  
  # 2. root設定
  root 'posts#index'
  # usersコントローラーのshowアクションのルーティングを追加、asオプションで名前付きルーティングを生成(user_path)
  get '/users/:id', to: 'users#show', as: 'user'
  
  # # 投稿ページを表示
  # get 'posts/new', to: 'posts#new'
  # # 投稿を作成
  # post '/posts', to: 'posts#create'
  # #投稿写真を保存
  # post '/posts/:post_id/photos', to: 'photos#create', as: 'post_photos'

  # resourcesメソッドで書き換え
  # posts親とphotos子が紐づく関係
  resources :posts, only: %i(new create index show destroy) do
    resources :photos, only: %i(create)

    resources :likes, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end
end
