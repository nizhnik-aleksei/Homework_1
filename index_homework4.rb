require 'pp'
require_relative 'developer'
require_relative 'junior_developer'
require_relative 'senior_developer'
require_relative 'team'

MESSAGES = {
    junior: 'Отдали задачу "%s" разработчику %s, следите за ним!',
    senior: '%s сделает "%s", но просит больше с такими глупостями не приставать',
    developer: '%s сделает "%s", как положено'
}

team = Team.new do
  have_seniors "Олег", "Оксана"
  have_developers "Олеся", "Василий", "Игорь-Богдан"
  have_juniors "Владислава", "Аркадий", "Рамеш"

    priority :juniors, :developers, :seniors

   on_task :junior do |dev, task|
    puts MESSAGES[:junior] % [task, dev.name]
  end

  on_task :senior do |dev, task|
    puts MESSAGES[:senior] % [dev.name, task]
  end

  on_task :developer do |dev, task|
    puts MESSAGES[:developer] % [dev.name, task]
  end
end