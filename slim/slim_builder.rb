class AppBuilder < Rails::AppBuilder
  def initialize(*args)
    super
    source_paths.unshift File.expand_path('../template', __FILE__)
  end

  def config
    super
    inside('config') do
      remove_dir 'initializers'
      remove_dir 'locales'
      
      template './application.rb'
      directory './environments'
    end
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
end