class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :album, counter_cache: true
    def created_time
        self.created_at.strftime('%H:%M %F')
    end

    def self.sort_time(comments)
        @sorted_comments = comments.sort_by{|a| a.created_at}
        @sorted_comments
    end
end
