object @today => :ping

node(:today) {|today| today.strftime("%F") }