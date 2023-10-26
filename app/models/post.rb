class Post < ApplicationRecord
    validates :title, presence: true, :length => { 
        :minimum => 4,
        :maximum => 255,
        :too_short => "must have at least %{count} characters",
        :too_long  => "must have at most %{count} characters",
    }
    has_many :comments
end
