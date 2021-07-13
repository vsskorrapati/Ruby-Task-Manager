class User < ApplicationRecord
    validates :email, presence:true
    # , uniqueness: true
    validates :provider, presence: true

    has_one :accesstoken, dependent: :destroy
    has_many :tasks, dependent: :destroy
end
