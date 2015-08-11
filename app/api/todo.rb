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
      post '', :rabl => 'authtoken' do
        user = User.where(email: params[:email]).first
        if user && user.authenticate(params[:password])
          unless @authtoken = AuthToken.create(email: params[:email], password: params[:password])
            error!(@authtoken.errors, 400)
          end
        else
          error!("email or password is wrong", 401)
        end
      end

      desc "logout"
      delete do
        # Tokenを削除する
      end
    end

    resource :task do
      desc "get tasks"
      get do
        # タスクを取得
      end

      desc "post task"
      post do
        # タスクを登録
      end

      desc "delete task"
      delete ':id' do
        # タスクを削除
      end
    end
  end
end