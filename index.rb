require "webrick"
require "erb"

# Class to deal the web requests
class MyServlet < WEBrick::HTTPServlet::AbstractServlet

    # method related to the GET request
    def do_GET (request, response)
        response.status = "200"
        if request.path == "/favicon.ico"
            response.content_type = "text/html"
            response.body = "\n"
        elsif request.path.index("assets").to_i > 0
            image = request.path[8, 99]
            response.body = File.read("assets/#{image}") + "\n"
        elsif request.path == "/"
            file = File.read("./templates/form.html")
            response.content_type = "text/html"
            response.body = file + "\n"
        else
            response.status = "404"
            response.body = "404\n"
        end
    end

    # methid related to the POST request
    def do_POST (request, response)
        if request.body.index("option=").nil? || (request.body.index("option=paper") != 0 && request.body.index("option=rock") != 0 && request.body.index("option=scissors") != 0)
            response.status = "400"
            response.content_type = "text/html"
            response.body = "invalid post" + "\n"
        else 
            require "./Game.rb"
            user_option = request.body[7,99]
            response.status = "200"
            message = Game.evaluate user_option 
            response.body = message + "\n"
            puts message
        end
    end
end

# WEbtrick things
server = WEBrick::HTTPServer.new(:Port => 8081)
server.mount "/", MyServlet

trap("INT") {
    server.shutdown
}

server.start