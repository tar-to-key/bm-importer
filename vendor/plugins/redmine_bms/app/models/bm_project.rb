# -*- coding: utf-8 -*-
class BmProject
  def create(bm)
    @bm = bm

    create_project
    create_versions
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
      if task[:issues].size > 0 then
        create_story_tickets(target, task[:issues])
      end
    end
  end

  def create_story_tickets(target, issues)
    # TODO
  end

  private

  def make_identifier
    a = ('a'..'z').to_a + ('0'..'9').to_a
    rands =  Array.new(32){a[rand(a.size)]}.join
    if Project.find_by_identifier(rands).nil? then
      return rands
    end
  end
end
