namespace :admin_creator do
  desc "creates admin user"
  task :create_admin => :environment do
    admin_data = {}
    puts 'Enter your name: '
    admin_data[:name] = STDIN.gets.chomp
    puts 'Enter email id: '
    admin_data[:email] = STDIN.gets.chomp
    puts 'Enter password: '
    admin_data[:password] = STDIN.gets.chomp
    puts 'Confirm password: '
    admin_data[:password_confirmation] = STDIN.gets.chomp
    admin_data[:type] = 'Admin'
    admin_data[:verified] = true
    admin_data[:credits] = 5
    admin = BaseUser.new(admin_data)
    if admin.save
      puts 'Admin successfully created'
    else
      p admin.errors
    end
  end
end
