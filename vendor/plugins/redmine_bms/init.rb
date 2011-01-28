# -*- coding: undecided -*-
require 'redmine'

Redmine::Plugin.register :redmine_bms do
  name 'Redmine Bms plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  #permission :view_bm_importers, {:imports => [:index]}, :public => true
  menu :application_menu, :bm_importers, { :controller => 'imports', :action => 'index' }, :caption => "Bm Import"

  project_module :bm_importers do
    permission :view_bm_importers, :imports => :index
  end

end
