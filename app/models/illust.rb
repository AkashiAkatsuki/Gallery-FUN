class Illust < ApplicationRecord

  def pic_url
    read_attribute(:pic_url).split(" ")
  end

  
  def tags
    tags = read_attribute(:tags).split("#")
    tags.shift 
    tags
  end

end
