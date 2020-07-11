json.text  @comment.content
json.user_id  @comment.user.id
json.user_name  @comment.user.nickname
json.created_at @comment.created_at.strftime('%Y/%m/%d %H:%M:%S')