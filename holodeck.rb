
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
  haml :index
end

post '/createiconset' do
  file_names = []
  params.keys.select{ |k| k.start_with? "image-data"}.each do |key|
    fname = image_file_name(key)
    data_url = params[key]
    data = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
    save(fname, data)
    file_names << fname
  end

  Zip::File.open("public/workspace/iconset-#{Time.now.to_i}.zip", Zip::File::CREATE) do |zipfile|
    file_names.each do |filename|
      # Two arguments:
      # - The name of the file as it will appear in the archive
      # - The original file, including the path to find it
      zipfile.add(filename, "public/workspace/" + filename)
      #File.delete("public/workspace/" + filename)
    end
  end
  redirect to('/')
  #content_type('image/octet-stream');
  #headers["Content-Disposition"] = "attachment;filename=ios180x180-#{Time.now.to_i}.png"
  #data_url = params["image-data"]
  #Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
end
