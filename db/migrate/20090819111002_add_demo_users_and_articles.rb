require 'declarative_authorization/maintenance'

class AddDemoUsersAndArticles < ActiveRecord::Migration
  include Authorization::Maintenance

  def self.up
    u1 = create_user_by_login("tony", ["author"])
    u2 = create_user_by_login("jacky", ["reviewer"])

    Authorization::Maintenance::without_access_control do
      a1 = Article.create :title => "first article", :content => "abc"*10, :author => u1
      a2 = Article.create :title => "second article", :content => "zxy"*10, :author => u1
      a3 = Article.create :title => "third article", :content => "opq"*10, :author => u2
      puts "Articles '#{a1.title}', '#{a2.title}', '#{a3.title}' created."
    end
  end

  def self.down
    delete_user_by_login("tony")
    delete_user_by_login("jacky")

    Authorization::Maintenance::without_access_control do
      Article.delete_all
      puts "All articles deleted."
    end
  end

  def self.create_user_by_login(login, roles=[])
    unless User.find_by_login(login)
      puts "Creating user '#{login}' ..."
      u = User.new
      u.signup!({:name => login, :email => "#{login}@example.com"}, false)
      u.activate!({:login => login, :password => login, :password_confirmation => login}, false)
      roles.each do |r|
        u.roles << Role.find_by_name(r.to_s)
      end
      puts "user '#{login}' created. login/password is #{login}/#{login}."
      u
    else
      puts "user '#{login}' already exists."
    end
  end

  def self.delete_user_by_login(login)
    if u = User.find_by_login(login)
      u.delete
      puts "user '#{login}' deleted."
    end
  end
end