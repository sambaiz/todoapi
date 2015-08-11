module Todo
  class API < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    resource :ping do
      desc "Return date"
      get '', :rabl => 'ping' do
        @today = Date.today
      end
    end

    resource :auth do
      desc "login"
      post do
        # 認証してTokenを返す
      end

      desc "logout"
      delete do
        # Tokenを削除する
      end
    end

    resource :task do
      desc "post task"
      post do
        # タスクを登録
      end

      desc "logout"
      delete ':id' do
        # タスクを削除
      end
    end
  end
end