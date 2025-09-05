class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :skip_password_validation

  # devise :database_authenticatable,
  devise :registerable,
         :cas_authenticatable,
         :recoverable,
         :rememberable,
         :trackable
        #  :validatable#,
        #  :confirmable

  royce_roles %w[
    institution-admin

    user-view
    user-update
    user-set-roles
    user-approve
    user-destroy

    diagram-create
    diagram-update
    diagram-destroy
    diagram-download
  ]


  belongs_to :institution

  validates :email, uniqueness: { message: "%{value} has already been taken." }
  validates :username, uniqueness: { message: "%{value} has already been taken." }
  validates :uid_number, uniqueness: { message: "%{value} has already been taken." }
  validates_presence_of :institution
  validates_presence_of :name, :title, :department

  has_many :user_diagrams, :dependent => :delete_all
  has_many :diagrams, :through => :user_diagrams
  has_many :user_logs, dependent: :destroy

  has_many :authored_diagrams, :class_name => "Diagram", :foreign_key => :creator_id

  after_create :send_admin_mail

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def role_dependencies
    {
        "user-update" => "user-view",
        "user-destroy" => "user-view",
        "user-approve" => "user-update",
        "user-set-roles" => "user-update",
        "diagram-update" => "diagram-create",
        "diagram-destroy" => "diagram-create"
    }
  end

  def dependent_roles
    {
        "user-view" => %w(user-update user-destroy user-approve user-set-roles),
        "user-update" => %w(user-approve user-set-roles),
        "diagram-create" => %w(diagram-update diagram-destroy)
    }
  end

  def cas_extra_attributes=(extra_attributes)
    # [["username", "divyansh"], ["LIMIT", 1]]
    # {"u_id"=>"119400043",
    # "sn"=>"Shrivastava",
    # "uid"=>"divyansh",
    # "givenName"=>"Divyansh",
    # "cn"=>"Divyansh Shrivastava",
    # "email"=>"divyansh@umd.edu",
    # "employeeNumber"=>"119400043"}
    extra_attributes.each do |name, value|
      case name.to_sym
      when :fullname
        self.fullname = valuesel
      when :email
        self.email = value
      end
    end
  end
end
