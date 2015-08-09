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
  end
end