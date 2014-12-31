
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
  header('Content-type: image/octet-stream');
  header('Content-disposition: attachment;filename=foo.png');
  params[:data]
end
