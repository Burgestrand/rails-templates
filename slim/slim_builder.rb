require 'tempfile'

class AppBuilder < Rails::AppBuilder
  def config
    super
    inside('config') do
      remove_dir 'initializers'
      remove_dir 'locales'
    end
      
    get_from_github 'config/application.rb', :force => true
    get_from_github 'config/routes.rb', :force => true
    [:production, :development, :test].each do |file|
      get_from_github "config/environments/#{file}.rb.tt", :force => true
    end
  end
  
  def app
    super
    get_from_github 'app/controllers/application_controller.rb.tt', :force => true
    get_from_github 'app/views/layouts/application.html.erb.tt', :force => true
  end
  
  # noop
  def database_yml
  end
  
  # noop
  def db
  end
  
  # noop
  def doc
  end
  
  def javascripts
    empty_directory_with_gitkeep 'public/javascripts'
  end
  
  # noop
  def readme
  end
  
  # noop
  def test
  end
  
  # noop
  def vendor_plugins
  end
  
  def public_directory
    super
    inside 'public' do
      remove_file 'robots.txt'
      copy_file 'favicon.ico', 'apple-touch-icon.png'
    end
  end
  
  def gitignore
    get github['gitignore'], '.gitignore'
  end
  
  def gemfile
    get github['Gemfile']
  end
  
  protected
    def github
      @__github__ ||= Hash.new { |h, (k, v)| h[k] = "https://github.com/Burgestrand/rails-templates/raw/master/slim/template/#{k}" }
    end
    
    def get_from_github(source, config = {})
      get_template github[source], source.gsub(/\.tt\Z/, ''), config
    end
  
    def get_template(source, destination = nil, config = {})
      destination ||= ::File.basename(source)
      Tempfile.open('') do |f|
        template get(source, f.path, :force => true), destination, config
      end
    end
end