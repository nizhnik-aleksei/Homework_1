class Team

  attr_reader :all

  def initialize(&block)
    @tasks_actions = {}
    @all = []
    instance_eval &block
  end

  def have_seniors(*names)
    set_member :seniors, SeniorDeveloper, names
  end

  def have_developers(*names)
    set_member :developers, Developer, names
  end

  def have_juniors(*names)
    set_member :juniors, JuniorDeveloper, names
  end

  def priority(*list)
    @priority = list
  end

  def on_task(type, &block)
    @tasks_actions[type] = block
  end

  def add_task(task, options={})

    available_complexity = [:senior, :developer, :junior]

    dev = case
      when (available_complexity.include? options[:complexity]) && (!options[:to].nil?)
        @all
          .select { |dev| dev.type == options[:complexity].to_s.insert(-1, 's').to_sym}
          .select { |dev| dev.name == options[:to]}
          .sort_by{ |dev| dev.tasks.size }
          .first
      when (available_complexity.include? options[:complexity])
        @all
          .select { |dev| dev.type == options[:complexity].to_s.insert(-1, 's').to_sym}
          .sort_by{ |dev| dev.tasks.size }
          .first
      when (!options[:to].nil?)
        @all
          .select { |dev| dev.name == options[:to]}
          .sort_by{ |dev| dev.tasks.size }
          .first
      else
        get_sorted_member.first
    end

    unless dev.nil?
      dev.add_task(task)
      @tasks_actions[to_single(dev.type)].call(dev, task)
    else
      raise 'Не смогли выбрать разработчика'
    end
  end

  def report
    get_sorted_member.each do |dev|
       puts "#{dev.name} (#{to_single(dev.type)}): #{dev.tasks.join(', ')}"
    end
  end

  def method_missing(method_name)
    if [:seniors, :developers, :juniors].include? method_name
      @all.select {|dev| dev.type == method_name}
    end
  end

  private
    def set_member(type, dev_class, names)
      names.each {|name| @all << dev_class.new(name, type)}
    end

    def get_sorted_member
      @all.sort_by { |dev| [dev.tasks.size, @priority.index(dev.type)] }
    end

    def to_single(name)
      name.to_s.chop.to_sym
    end
end