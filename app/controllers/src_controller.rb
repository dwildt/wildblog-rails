class SrcController < ActionController::Base

  def index
    orig_path = params[:path].to_s
    path = File.expand_path(File.join(Rails.root, orig_path))
    if path =~ /session_store/
      render :text => 'Sorry, this file is secret'
    elsif File.directory? path
      if orig_path.empty? || orig_path[-1] == ?/
        @path = "./" + orig_path
        @entries = Dir.entries(path)[2..-1]
      else
        redirect_to :path => orig_path
      end
    elsif File.exists? path
      mime = path[-4..-1].eql?('.xml') ? "text/xml" : "text/plain"
      response.headers["Content-Type"] = mime unless path[-4..-1].eql?('.jar') 
      render :text => IO.read(path)
    else
      render :file => "#{RAILS_ROOT}/public/404.html", :status => "404 Not Found"
    end
  end

end
