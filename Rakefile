require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    if %w[Rakefile README.rdoc LICENSE].include? file ||
      file.start_with? "."
      puts "Ignoring #{file}"
      next
    end

    destination_basename = ".#{file.sub('.erb', '')}"
    destination_file = File.join(ENV["HOME"], destination_basename )
    
    if File.exist?(destination_file)
      if File.identical? file, destination_file
        puts "identical ~/#{destination_basename}"
      elsif replace_all
        replace_file(file, destination_file)
      else
        print "overwrite ~/#{destination_basename}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file, destination_file)
        when 'y'
          replace_file(file, destination_file)
        when 'q'
          exit
        else
          puts "skipping ~/#{destination_basename}"
        end
      end
    else
      link_file(file, destination_file)
    end
  end
end

def replace_file(file, destination_file)
  File.unlink(destination_file)
  link_file(file, destination_file)
end

def link_file(file, destination_file)
  if file =~ /.erb$/
    puts "generating #{destination_file}"
    File.open(destination_file, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking #{destination_file} to #{file}"
    File.symlink(File.expand_path(file), destination_file)
  end
end
