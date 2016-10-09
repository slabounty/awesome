namespace :parser do
  desc "Build the parser using racc"
  task :build do
    `racc -o lib/awesome/parser.rb lib/awesome/grammar.y`
  end
end
