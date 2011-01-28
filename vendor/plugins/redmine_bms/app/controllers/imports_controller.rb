# -*- coding: utf-8 -*-
class ImportsController < ApplicationController
  unloadable
  before_filter :find_project
  before_filter :redirect, :only => :confirm

  def index
    #unless flash.clear if flash[:error]?
  end

  def confirm
    xml = XmlData.new
    xml.parse params[:file]['xml_data']
    @project_name = xml.get_project_name
    @tasks = xml.get_tasks

    flash[:project_name] = @project_name
    flash[:tasks] = @tasks
    render :layout => 'confirm_base'
  end

  def complete
    @project_name = flash[:project_name]
    bm_project = BmProject.new
    bm_project.update(@project, flash)
    render :layout => 'confirm_base'
  end

  private

  def find_project
    begin
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def redirect
    unless params[:file]
      flash[:error] = 'ファイルを指定してください'
      redirect_to :action => 'index', :project_id => params[:project_id]
    end
  end
end
