class VaultEntry < ApplicationRecord
  belongs_to :user

  encrypts :title
  encrypts :body

  enum :kind, { note: 0, credential: 1 }, validate: true

  validates :title, presence: true
end
