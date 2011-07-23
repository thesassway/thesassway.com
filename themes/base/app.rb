module Nesta
  class App
    use Rack::Static, :urls => ['/base'], :root => 'themes/base/public'
  end
end
