class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :null => false
      t.string :title

      t.timestamps
    end

    create_table :roles_users, :id => false do |t|
      t.references :user, :null => false
      t.references :role, :null => false
    end

    Role.find_or_create_by_name(:name => 'member', :title => 'Member')
    Role.find_or_create_by_name(:name => 'author', :title => 'Author')
    Role.find_or_create_by_name(:name => 'manager', :title => 'Manager')
    Role.find_or_create_by_name(:name => 'admin', :title => 'Administrator')
    puts "Roles (member, author, manager, admin) created."


    unless User.find_by_login('root')
      puts 'Creating root user ...'
      root_user = User.create(
        :name => "Root User",
        :login => 'root',
        :password => 'root',
        :password_confirmation => 'root',
        :email => "root@example.com"
      )
      root_user.admin = true
      root_user.state = "active"
      root_user.save(false)
      puts "Root user created. login/password is root/root. Please change immediately!"
    else
      puts 'Root user already exists.'
    end

    User.find_by_login('root').roles << Role.find_by_name('admin')

  end

  def self.down
    drop_table :roles_users
    drop_table :roles
  end
end
