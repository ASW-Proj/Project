module CommentsHelper
    def display_comments(comments)
      comments.each do |comment|
        render(partial: 'comments/comment', locals: { comment: comment })
  
        if comment.children.any?
          content_tag(:div, class: 'nested-comments') do
            display_comments(comment.children)
          end
        end
      end
    end
  end