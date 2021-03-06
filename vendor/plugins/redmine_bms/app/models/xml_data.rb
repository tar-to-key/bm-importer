# -*- coding: utf-8 -*-
class XmlData
  def parse(xml = nil)
    xml = xml.read.gsub(/\r\n/,'')
    @xml = Nokogiri::XML.parse(xml, 'utf-8')
  end

  def self.allxml
    return 'all'
  end

  def self.hoge
    return @xml
  end

  def get_project
    result = Hash.new
    result[:name] = @xml.xpath("//ProjectInformation/Name").children.inner_text
    result[:description] = @xml.xpath("//ProjectInformation/ProjectMemo").children.inner_text
    return result
  end

  def get_tasks
    result = Hash.new
    @xml.search("//TaskRepository/Tasks/Task").each do | task |
      id   = task.search("./Id").children.inner_text
      name = task.search("./Name").children.inner_text
      issues = get_issues(task)

      finish = task.search("./Finish").children.inner_text
      result[id] = { :name => name, :finish => finish[0..9], :issues => issues }
    end
    return result
  end

  def get_issues(task)
    result = Hash.new
    task.search("./Children/Task").each do | child |
      tmp = Hash.new
      id = child.search("./Id").children.inner_text
      result[id] = {
        :name => child.search("./Name").children.inner_text,
        :discription => child.search("./Memo").children.inner_text,
        :start => child.search("./Start").children.inner_text[0..9],
        :end => child.search("./Finish").children.inner_text[0..9]
      }
    end
    return result
  end
end
