# frozen_string_literal: true

task create_role: :environment do
  roles = ["default", "author", "admin"]
  roles.each do |role|
    puts "Creating/Finding role #{role}"
    Role.find_or_create_by(name: role)
  end
end