
configure do
  set :pua, YAML::load_file(File.dirname(__FILE__) + '/pua.yml')
end

helpers do
  def iconh(i)
    "<i class='fa #{i[:name]}'></i>"
  end
end

get '/' do
  @icons= settings.pua
  haml :index
end

post '/download' do
  content_type('image/octet-stream');
  headers["Content-Disposition"] = "attachment;filename=ios180x180-#{Time.now.to_i}.png"
  data_url = params["image-data"]
  Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
end
