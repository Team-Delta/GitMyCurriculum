# Manager for creating comments
module CommentManager
  # handles creation of a comment
  #
  # +creator+:: of the comment
  # +join request+:: that the comment is in
  # +text+:: contents of the comment
  # +comment+:: parent comment
  def create_comment_for(creator, request, message, parent = nil)
    @comment = Comment.new
    @comment.attributes = { creator: creator, join_request: request, parent_comment: parent, message: message }
    @comment.save
  end
end
