# -*- coding: utf-8 -*-
class ImportsController < ApplicationController
  unloadable
  before_filter :redirect, :only => :confirm

  def index
  end

  def confirm
    xml = XmlData.new
    xml.parse(params[:file]['xml_data'])
    @bm_project = xml.get_project
    @tasks = xml.get_tasks

    flash[:project] = @bm_project
    flash[:tasks] = @tasks

    render :layout => 'confirm_base'
  end

  def complete
    @project_name = flash[:project][:name]
    bm_project = BmProject.new
    bm_project.create(flash)
    render :layout => 'confirm_base'
  end

  private

  def redirect
    unless params[:file]
      flash[:error] = 'ファイルを指定してください'
      redirect_to :action => 'index', :project_id => params[:project_id]
    end
  end
end
