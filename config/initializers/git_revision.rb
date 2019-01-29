module Git
  REVISION = File.exists?(File.join(Rails.root, 'REVISION')) ? File.open(File.join(Rails.root, 'REVISION'), 'r') { |f| GIT_REVISION = f.gets.chomp } : nil
  VERSION = File.exists?(File.join(Rails.root, 'VERSION')) ? File.open(File.join(Rails.root, 'VERSION'), 'r') { |f| GIT_VERSION = f.gets.chomp } : nil
end