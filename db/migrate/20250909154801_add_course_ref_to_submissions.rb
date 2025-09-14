class AddCourseRefToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_reference :submissions, :course, null: false, foreign_key: true, null: true
  end
end
