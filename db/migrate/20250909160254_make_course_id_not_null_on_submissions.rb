class MakeCourseIdNotNullOnSubmissions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :submissions, :course_id, false
  end
end
