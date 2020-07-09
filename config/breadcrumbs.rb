crumb :root do
  link "Home", root_path
end

# 新規登録
crumb :sign_in do
  link "新規登録", new_user_registration_path
  parent :root
end

# 住所情報登録
crumb :address_in do
  link "住所情報登録", addresses_path
  parent :sign_in
end

# ログイン
crumb :log_in do
  link "ログイン", new_user_session_path
  parent :root
end

# マイページ
crumb :user do
  link "マイページ", user_path(current_user.id)
  parent :root
end

# コーディネート選択
# crumb :select_coordinate do
#   link "コーディネート選択", user_path
#   parent :user
# end

# コーディネート一覧
crumb :index_coordinate do
  link "コーディネート一覧", coordinates_path
  parent :user
end

# コーディネート登録
crumb :new_coordinate do
  link "コーディネート登録", new_coordinate_path
  parent :index_coordinate
end

# コーディネート詳細
crumb :show_coordinate do
  link "コーディネート詳細", coordinate_path
  parent :index_coordinate
end

# コーディネート編集
crumb :edit_coordinate do
  link "コーディネート編集", edit_coordinate_path
  parent :show_coordinate
end

# お気に入り一覧
crumb :bookmark do
  link "お気に入り一覧", coordinate_bookmarks_path
  parent :user
end

# アイテム一覧
crumb :index_item do
  link "アイテム一覧", items_path
  parent :user
end

# アイテム登録
crumb :new_item do
  link "アイテム登録", new_item_path
  parent :index_item
end

# アイテム詳細
crumb :show_item do
  link "アイテム詳細", item_path
  parent :index_item
end

# アイテム編集
crumb :edit_item do
  link "アイテム編集", edit_item_path
  parent :show_item
end

# 閲覧履歴
crumb :history do
  link "閲覧履歴", history_coordinates_path
  parent :user
end

# プロフィール
crumb :profile do
  link "プロフィール", address_path
  parent :user
end

# 住所変更
crumb :street_address do
  link "住所変更", edit_address_path
  parent :user
end

# メール・パスワード変更
crumb :email_password do
  link "メール・パスワード変更", edit_user_registration_path
  parent :user
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).