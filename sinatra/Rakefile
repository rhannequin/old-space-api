Dir[File.expand_path('tasks/**/*.rake', File.dirname(__FILE__))].each { |file| load file }

task default: :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end
