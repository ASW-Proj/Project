class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end

  def vista2
    render html:"vista 2"
  end

end
