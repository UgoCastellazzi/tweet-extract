class Alert < ApplicationRecord
  belongs_to :user
  has_many :leads, dependent: :destroy
end
