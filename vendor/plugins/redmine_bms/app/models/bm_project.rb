# -*- coding: utf-8 -*-
class BmProject
  def update(project, bm)
    @project = project
    @bm = bm
    update_project
    create_versions
  end

  private

  def update_project
    @project.name = @bm[:project_name]
    @project.save
  end

  def create_versions
    @bm[:tasks].each do | k, task |
      target = Version.new
      target.project_id = @project.id
      target.name = task[:name]
      target.effective_date = task[:finish]
      target.status = 'open'
      target.sharing = 'none'
      target.save!
    end
  end

  def create_story_tickets
  end

end
