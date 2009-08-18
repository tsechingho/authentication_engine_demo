authorization do
  role :guest, :title => "Guest" do
    description "The default role for anonymous user"
    # Don't remove this or you can't signup
    has_permission_on :users, :to => :create
    has_permission_on :articles, :to => [:read]
  end

  role :member, :title => "Member" do
    description "The default role for authenticated user"
    #show/update account, invite friends
    has_permission_on :users, :to => [:show, :update, :create]
    has_permission_on :articles, :to => [:read]
  end

  role :author, :title => "Author" do
    description "The default role for author"
    has_permission_on :users, :to => [:show, :update]
    has_permission_on :articles, :to => [:read, :create]
    has_permission_on :articles, :to => [:update, :delete, :confirm] do
      if_attribute :author => is {user}
    end
  end

  role :reviewer, :title => "Reviewer" do
    description "The default role for reviewer"
    has_permission_on :users, :to => [:show, :update]
    has_permission_on :articles, :to => [:read, :approve] do
      if_attribute :author => is_not {user}
    end
  end

  role :manager, :title => "Manager" do
    description "The default role for manager"
    has_permission_on :users, :to => [:show, :update]
  end

  role :admin, :title => "Administrator" do
    description "The powerest role of the system"
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
    has_permission_on :users, :to => :manage
    has_permission_on :roles, :to => :manage
    has_permission_on :articles, :to => [:manage, :confirm, :approve]
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
