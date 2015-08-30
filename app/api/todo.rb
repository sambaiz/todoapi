module Todo
  class API < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    helpers do
      def current_user(token)
        @token = AuthToken.where(token: token).first
        if @token.nil?
          @current_user = nil
        else
          @current_user = @token.user
        end
      end

      def authenticate!(token)
        error!('401 Unauthorized', 401) unless current_user(token)
      end
    end

    resource :ping do
      desc "Return date"
      get '', :rabl => 'ping' do
        @today = Date.today
      end
    end

    resource :auth do
      desc "login"
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post '', :rabl => 'auth_token' do
        user = User.where(email: params[:email]).first
        if user && user.authenticate(params[:password])
          @authtoken = AuthToken.create(user_id: user.id, token: "AAAAA", expired_at: Date.new)
          if @authtoken.errors.size != 0
            error!(@authtoken.errors, 400)
          end
        else
          error!("email or password is wrong", 401)
        end
      end

      desc "logout"

      delete do
        authenticate!(headers['Token'] || params[:token])
        @token.destroy
        { result: "success" }
      end
    end

    resource :user, :rabl => 'auth_token' do
      desc "register"
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post '', :rabl => 'auth_token'  do
        user = User.create(email: params[:email], password: params[:password])
        if user.errors.size != 0
          error!(user.errors, 400)
        end

        @authtoken = AuthToken.create(user_id: user.id, token: "AAAAA", expired_at: Date.new)
        if @authtoken.errors.size != 0
          error!(@authtoken.errors, 400)
        end
      end
    end

    resource :task, :rabl => 'auth_token' do
      desc "get tasks"
      params do
        optional :token, type: String
      end
      get '/', :rabl => 'tasks' do
        authenticate!(headers['Token'] || params[:token])
        @tasks = @current_user.tasks
      end

      desc "post task"
      params do
        requires :title, type: String
        requires :description, type: String
        optional :token, type: String
      end
      post do
        authenticate!(headers['Token'] || params[:token])
        task = Task.create(user_id: @current_user.id, title: params[:title], description: params[:description])
        if task.errors.size != 0
          error!(task.errors, 400)
        end
        { result: "success" }
      end

      desc "delete task"
      params do
        optional :token, type: String
      end
      delete ':id' do
        authenticate!(headers['Token'] || params[:token])
        task = Task.find(params[:id])
        if task.user.id == @current_user.id
          task.destroy
          { result: "success" }
        else
          error!('403 Forbidden', 403)
        end
      end
    end
  end
end