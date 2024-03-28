# runs by rails todos:load
namespace :todos do
    desc "load all todos"
    task load: :environment do
        todos = Todo.all
        puts "Loaded #{todos.count} todos:"
        todos.each do |todo|
            puts "#{todo.id}: #{todo.title}"
        end
    end
end