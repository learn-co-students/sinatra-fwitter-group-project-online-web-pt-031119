class User < ActiveRecord::Base
    include Slugfiable:InstanceMethods
    extend Slugfiable:ClassMethods
    has_secure_password
    has_many :tweets
end
