# vim: ft=ruby
Pry.config.prompt = [
    -> obj, nest_level, _ { "#{obj}(#{nest_level}):#{Pry.current_line.to_s.rjust(3, ?0)}> " },
    -> obj, nest_level, _ { "#{obj}(#{nest_level}):#{Pry.current_line.to_s.rjust(3, ?0)}* " }
]
