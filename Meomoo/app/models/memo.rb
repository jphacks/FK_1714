class Memo < ApplicationRecord
  validates :text, presence: true
end
