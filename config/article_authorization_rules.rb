authorization do
  role :guest, :title => "Guest3" do
    has_permission_on :articles, :to => [:read]
  end

  role :member do
    has_permission_on :articles, :to => [:read]
  end

  role :author do
    has_permission_on :articles, :to => [:read, :create]
    has_permission_on :articles, :to => [:update, :delete, :confirm] do
      if_attribute :author => is {user}
    end
  end

  role :reviewer do
    has_permission_on :articles, :to => [:read, :approve] do
      if_attribute :author => is_not {user}
    end
  end

  role :manager do
    has_permission_on :articles, :to => [:manage, :confirm, :approve]
  end

  role :admin do
    has_permission_on :articles, :to => [:manage, :confirm, :approve]
  end
end
