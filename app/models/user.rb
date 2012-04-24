class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  								:name, :title, :dept, :projects, :bio

	def self.search(search)
	  if search
	    find(:all, :conditions => ['lower(name) LIKE ? OR lower(title) LIKE ? 
	    	OR lower(dept) LIKE ? OR lower(projects) LIKE ?', 
	    	"%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
	  else
	    find(:all)
	  end
	end  								
end
