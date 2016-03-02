require_relative 'developer'

class JuniorDeveloper < Developer

  class TooDifficult < StandardError; end

  MAX_TASKS = 5
  TASK_LENGTH = 20

  def add_task(task)
    if task.size > TASK_LENGTH
      raise TooDifficult, 'Слишком сложно!'
    end
    super
  end

  def work!
    check_tasks
    puts %Q{%s: пытаюсь делать задачу "%s". Осталось задач: %i} %
        [@name, @tasks.shift, @tasks.size]
  end

end