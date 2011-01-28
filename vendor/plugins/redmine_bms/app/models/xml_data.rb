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

  def get_project_name
    @xml.xpath("//ProjectInformation/Name").children.inner_text
  end

  def get_tasks
    result = Hash.new
    @xml.search("//TaskRepository/Tasks/Task").each do | task |
      id   = task.search("./Id").children.inner_text
      name = task.search("./Name").children.inner_text
      finish = task.search("./Finish").children.inner_text
      result[id] = { :name => name, :finish => finish }
    end
    return result
  end

  def get_test
    result = Hash.new
    @xml.xpath("//TaskRepository/Tasks/Task")
    raise @xml.class.inspect
    return result
  end
end
