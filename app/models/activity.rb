class Activity < ActiveRecord::Base
  has_many :comments, as: :commentable

  # DB FIELDS
  # t.integer  "trackable_id"
  # t.string   "trackable_type"
  # t.integer  "owner_id"
  # t.string   "owner_type"
  # t.string   "key"
  # t.text     "parameters"
  # t.integer  "recipient_id"
  # t.string   "recipient_type"
end
