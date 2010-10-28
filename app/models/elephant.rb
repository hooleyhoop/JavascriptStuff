# == Schema Information
# Schema version: 20101028093342
#
# Table name: elephants
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Elephant < ActiveRecord::Base
  
  attr_accessible :name, :email
  
end
