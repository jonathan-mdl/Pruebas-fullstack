require 'uri'
require 'json'
require 'net/http'


def get_photos(url_api,api_key)
    param_api_key ='&api_key='+api_key
    url_request = url_api + param_api_key
    url = URI(url_request)
    http = Net::HTTP.new(url.host, url.port)
    
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)   
    response = http.request(request)
    puts 'URL REQUEST: '+url_request
    puts 'response'+response.read_body
    return JSON.parse(response.read_body)
end

def build_web_page(hash_photos)
    html_inicio = "<!DOCTYPE html>
    <html>
    <head>
    <meta charset='UTF-8'>\n
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>\n
    <meta http-equiv='X-UA-Compatible' content='ie=edge'>\n
    <title>Document</title>\n
    </head>
    <body>
    <ul>"

    html_final = "</ul>
    </body>
    </html>"

    html_photos = ""

    hash_photos['photos'].each do |photo|
        html_photos = html_photos +
        "<li>
        <div>"+photo['camera']['full_name']+ "</div>
        <img src='"+photo['img_src']+"'>    
        </li>\n"
     end 
    
     File.open('prueba-ruby.html', 'w') do |f|
        f.puts html_inicio
        f.puts html_photos
        f.puts html_final
    end
end

json_fotos = get_photos("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz","DEMO_KEY")
buid_web_page(json_fotos)

def photos_count(json_fotos)
    
end