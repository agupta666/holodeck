
configure do
  set :pua, YAML::load_file(File.dirname(__FILE__) + '/pua.yml')
end

helpers do
  def iconh(i)
    "<i class='fa #{i[:name]}'></i>"
  end

  def image_file_name(k)
    "app-icon#{k.gsub(/image-data/, "").gsub(/p/, 'pt@')}.png"
  end

  def save(fname, data)
    File.write("public/workspace/#{fname}", data)
  end
end

get '/' do
  @icons= settings.pua
  @zip_files= Dir.entries("public/workspace").select{ |e| e.end_with? ".zip" }
  haml :index
end

post '/createiconset' do
  Zip::File.open("public/workspace/iconset-#{Time.now.to_i}.zip", Zip::File::CREATE) do |zipfile|
    params.keys.select{ |k| k.start_with? "image-data"}.each do |key|
      filename = image_file_name(key)
      data_url = params[key]
      zipfile.get_output_stream(filename) { |os| os.write Base64.decode64(data_url['data:image/png;base64,'.length .. -1]) }
    end
  end
  redirect to('/')
end

post '/trash/:filename' do |file_name|
  File.delete("public/workspace/" + file_name)
  file_name.gsub(/.zip/, '')
end
