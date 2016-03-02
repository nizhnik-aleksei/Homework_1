class Developer

  class EmptyTasks < StandardError; end
  class TooMuchTasks < StandardError; end

  def initialize(name, type)
    @name = name
    @type = type
    @tasks = []
  end

  MAX_TASKS = 10
  STATUSES = {free: 'свободен', working: 'работаю', busy: 'занят'}

  attr_accessor :name, :type
  attr_reader :tasks

  def add_task(task)
    if @tasks.size >= self.class::MAX_TASKS
      raise TooMuchTasks, 'Слишком много работы!'
    end

    @tasks << task

    puts %Q{%s: добавлена задача "%s". Всего в списке задач: %i} % [@name, task, @tasks.size]
  end

  def check_tasks
    raise EmptyTasks, 'Нечего делать!' if @tasks.empty?
  end

  def work!
    check_tasks

    puts %Q{%s: выполнена задача "%s". Осталось задач: %i} % [@name, @tasks.shift, @tasks.size]
  end

  def status
    case
      when @tasks.empty?
        STATUSES[:free]
      when @tasks.size < self.class::MAX_TASKS
        STATUSES[:working]
      else
        STATUSES[:busy]
    end
  end

  def can_add_task?
    status != STATUSES[:busy]
  end

  def can_work?
    status != STATUSES[:free]
  end
end