# -*- coding: utf-8 -*-
class BmProject
  def create(bm)
    @bm = bm

    create_project
    create_versions
#    raise @bm[:tasks].inspect
  end

  private

  def create_project
    project = Project.new
    project.name = @bm[:project][:name]
    project.description = @bm[:project][:description]
    project.identifier = make_identifier
    project.is_public = true
    project.status = 1
    project.save!
    @project = project
  end

  def create_versions
    @bm[:tasks].each do | key, task |
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

  def make_identifier
    a = ('a'..'z').to_a + ('0'..'9').to_a
    rands =  Array.new(32){a[rand(a.size)]}.join
    if Project.find_by_identifier(rands).nil? then
      return rands
    end
  end

  def make_lft
    project = Project.find(:first, :order => "rgt DESC")
    return project.rgt.to_i + 1
  end

end
